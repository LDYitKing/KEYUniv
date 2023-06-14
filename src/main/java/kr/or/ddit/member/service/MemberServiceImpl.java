package kr.or.ddit.member.service;

import java.io.File;
import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.attatch.service.AttatchFileGroupService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.member.dao.MemberDAO;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.vo.MailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

   @Inject
   private MemberDAO memberDAO;
   
   @Inject
   @Named("passwordEncoder")
   private PasswordEncoder encoder;

   @Override
   public List<MemberVO> searchId(MemberVO member) {
      return memberDAO.searchId(member);
   }

   @Override
   public MailVO searchPasswd(MemberVO input) {
	  MailVO mailVO = new MailVO();

      MemberVO member = memberDAO.searchPasswd(input);
      mailVO.setSuccessYn(false);
      
      if (member != null) {
    	  mailVO.setSuccessYn(true);
          mailVO.setReceiver(member.getMemEmail());
          
          String newpassword = makeNewpassword();
          String encoded = encodingPassword(newpassword);
          
          // 임시 비밀번호로 정보 수정
          member.setMemPass(encoded);
          int cnt = memberDAO.updateMemberPasswd(member);
          
          // 메일 제목, 내용
          mailVO.setTitle("[KEY대] 임시 비밀번호 입니다.");
          String mailContent = String.format("임시 비밀번호 : %s", newpassword);
          mailVO.setContent(mailContent);
      }

      return mailVO;
   }

   // 임시 비밀번호 생성
   private String makeNewpassword() {
      String newpassword = "";

      // (영영숫영영숫=6자리)
      for (int i = 1; i <= 6; i++) {
         if (i % 3 != 0) {
            newpassword += RandomStringUtils.randomAlphabetic(1);
         } else {
            newpassword += RandomStringUtils.randomNumeric(1);
         }
      }
      log.info("newpassword : {}", newpassword);
      
      return newpassword;
   }
   
   // 비밀번호 암호화
   private String encodingPassword(String newpassword) {
      String encoded = encoder.encode(newpassword);
      log.info("encoded password : {}", encoded);
      
      return encoded;
   }

@Override
public int modifyMemberPasswd(MemberVO member) {
	String changePasswd = member.getMemPass();
	String encoded = encodingPassword(changePasswd);
	member.setMemPass(encoded);
	
	log.info("변경할 비밀번호 : {}", changePasswd);
	log.info("변경할 비밀번호 암호화 : {}", encoded);
	
	// 새로운 비밀번호로 정보 변경
	int cnt = memberDAO.updateMemberPasswd(member);
	return cnt;
}

}