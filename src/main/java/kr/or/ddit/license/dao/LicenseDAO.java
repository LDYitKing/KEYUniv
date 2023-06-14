package kr.or.ddit.license.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.facility.vo.FacilityVO;
import kr.or.ddit.license.vo.LicenseVO;
import kr.or.ddit.vo.Pagination;

@Mapper
public interface LicenseDAO {

	public int insertLicens(LicenseVO license);
	
	public int updateLicens(LicenseVO license);
	
	public int deleteLicens(LicenseVO condition);
	
	public List<LicenseVO> selectLicensList(Pagination<LicenseVO> pagination);
	
	
}
