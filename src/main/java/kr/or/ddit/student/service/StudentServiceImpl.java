package kr.or.ddit.student.service;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.attatch.service.AttatchFileGroupService;
import kr.or.ddit.attatch.vo.AttatchFileGroupVO;
import kr.or.ddit.attatch.vo.AttatchFileVO;
import kr.or.ddit.dgrade.dao.DgradeDAO;
import kr.or.ddit.dgrade.vo.DgradeVO;
import kr.or.ddit.member.dao.MemberDAO;
import kr.or.ddit.student.dao.StudentDAO;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StudentServiceImpl implements StudentService {

   @Inject
    private StudentDAO studentDAO;
   @Inject
   private DgradeDAO dgradeDAO;
   @Inject
   private MemberDAO memberDAO;
      
   @Inject
   private AttatchFileGroupService fileService;
      
   @Value("#{appInfo['member.attatchPath']}")
   private File saveFolder;
   
   @Inject
   private PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();

   
   @Override
   public List<StudentVO> retrieveStudentList(Pagination<StudentVO> pagination) {
      pagination.setTotalRecord(studentDAO.selectTotalRecord(pagination));
      List<StudentVO> studentList = studentDAO.selectStudentList(pagination);
      pagination.setDataList(studentList);
      return studentList;
   }


   @Override
   public void createStudent(StudentVO student) {
      // 1. 졸업 요건 테이블 insert
      DgradeVO dgrade = new DgradeVO();
      dgrade.setDeptNo(student.getDeptNo());
      dgrade.setMemNo(student.getMemNo());
      dgradeDAO.insertStuDgrade(dgrade);
      
      student.setDrNo(dgrade.getDrNo());
      
      // 2. member 테이블 insert
      student.setMemRole("ROLE_STU");
      
       String encoded = encoder.encode(student.getMemRrno1());
       student.setMemPass(encoded);
       
       AttatchFileGroupVO atchFileGroup = student.getAtchProfileGroup();
       Optional.ofNullable(atchFileGroup)
          .ifPresent((afg)->{
             fileService.createAttatchFileGroup(afg, saveFolder);
             student.setMemPhoto(afg.getAtchId());
          });
       
       log.info("student : {}", student);
      memberDAO.insertMember(student);
      
      // 3. student 테이블 insert
      studentDAO.insertStudent(student);
      
   }


   @Override
   public String retrieveStudentNoForDept(Map<String, String> param) {
      return studentDAO.selectStudentNoForDept(param);
   }


	@Override
	public void modifyStudent(StudentVO student) {
		StudentVO saved = retrieveStudentForAuth(student.getMemNo());
		log.info("saved: {}", saved);
		log.info("student.getMemPhoto(): {}", student.getMemPhoto());
		log.info("student.getMemPhotoFile(): {}", student.getMemPhotoFile());
		if(student.getMemPhotoFile()==null||student.getMemPhotoFile().isEmpty()) {
			student.setMemPhoto(saved.getMemPhoto());
		}else {
			// 이전 첨부파일(메타데이터, 이진데이터) 삭제
			if(saved.getMemPhoto()!=null) {
				fileService.removeAttatchFileGroup(saved.getMemPhoto(), saveFolder);
			}
			
			// 새 첨부파일(메타데이터, 이진데이터) 저장
//	       student.setMemPhotoFile(student.getMemPhotoFile());
	       AttatchFileGroupVO atchFileGroup = student.getAtchProfileGroup();
	       Optional.ofNullable(atchFileGroup)
	          .ifPresent((afg)->{
	             fileService.createAttatchFileGroup(afg, saveFolder);
	             student.setMemPhoto(afg.getAtchId());
	          });
			
		}
		
		memberDAO.updateMember(student);
	}

	@Override
	public StudentVO retrieveStudentForAuth(String memNo) {
		StudentVO student = studentDAO.selectStudentForAuth(memNo);
		if(student==null) throw new RuntimeException();
		
		return student;
	}

   
}


