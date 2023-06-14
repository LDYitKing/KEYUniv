package kr.or.ddit.sch.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.PKNotFoundException;
import kr.or.ddit.member.vo.MemberVOWrapper;
import kr.or.ddit.sch.dao.SchDAO;
import kr.or.ddit.sch.vo.SchRecVO;
import kr.or.ddit.sch.vo.SchVO;
import kr.or.ddit.vo.Pagination;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SchServiceImpl implements SchService {
	
	@Inject
	private SchDAO schDAO;
	
	@Override
	public ServiceResult createSch(SchVO sch) {
		int result = schDAO.insertSch(sch);
		return result>0? ServiceResult.OK : ServiceResult.FAIL;
	}
//장학금 목록 출력-------------------------------------------------------------------------------------------------------------------------------
	
	@Override 
	public List<SchVO> retrievSchList(Pagination<SchVO> pagination) {
		pagination.setTotalRecord(schDAO.selectTotalRecord(pagination));
		List<SchVO> schList = schDAO.selectSchList(pagination);
		pagination.setDataList(schList);
		return schList;
	}

//장학금 학과 목록------------------------------------------------------------------------------------------------------------------------------
	
	@Override
	   public String retrieveSchNoForDept(Map<String, String> param) {
	      return schDAO.selectSchNoForDept(param);
	   }
	
//--------------------------------------------------------------------------------------------------------------------------------	
	@Override
	public SchVO retrieveSch(String schNo) {
		return schDAO.selectSch(schNo);
	}
//--------------------------------------------------------------------------------------------------------------------------------
	
	@Override
	public ServiceResult modifySch(SchVO sch)throws PKNotFoundException{
		log.info("SchVO : {}", sch);
		
		int result = schDAO.updateSch(sch);
		
		if(result==0) {
			throw new PKNotFoundException(sch.getSchNo());
		}
		return ServiceResult.OK;
	}
	
//--------------------------------------------------------------------------------------------------------------------------------	
	@Override
	public void removeSch(SchVO condition) {
		retrieveSch(condition.getSchNo());
		schDAO.deleteSch(condition);
	}
//--------------------------------------------------------------------------------------------------------------------------------
	@Override
	public List<SchRecVO> retrievSchRecList(Pagination<SchRecVO> pagination, String memRole) {
		pagination.setTotalRecord(schDAO.selectRecTotalRecord(pagination));
		List<SchRecVO> schRecList = null;
		if(memRole != null) {
			if(memRole.equals("ROLE_EMP")) {
				schRecList = schDAO.selectSchRecList(pagination);
			}else if(memRole.equals("ROLE_STU")) {
				schRecList = schDAO.selectSchRecMemList(pagination);
			}
		}
		pagination.setDataList(schRecList);
		return schRecList;
		
	}
//--------------------------------------------------------------------------------------------------------------------------------	
	
	@Override
	public void createSchRec(SchRecVO schrec) {
		schDAO.insertSchRec(schrec);
	}
//--------------------------------------------------------------------------------------------------------------------------------	
	
	@Override
	public SchRecVO retrieveSchRec(String schRecNo) {
		return schDAO.selectSchRec(schRecNo);
	}

//--------------------------------------------------------------------------------------------------------------------------------
	@Override
	public ServiceResult modifySchRec(SchRecVO schRec) throws PKNotFoundException{
		log.info("SchVO : {}", schRec);
		
		int result = schDAO.updateSchRec(schRec);
		
		if(result==0) {
			throw new PKNotFoundException(schRec.getSchRecNo());
		}
		return ServiceResult.OK;
	}
//--------------------------------------------------------------------------------------------------------------------------------
	@Override
	public void removeSchRec(SchRecVO condition) {
		retrieveSchRec(condition.getSchRecNo());
		schDAO.deleteSchRec(condition);
	}
//--------------------------------------------------------------------------------------------------------------------------------	
	
}
