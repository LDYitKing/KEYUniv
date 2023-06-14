package kr.or.ddit.facility.vo;

import java.time.LocalDate;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.validate.DeleteGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "frNo")
public class FacilityResVO {
		
	@NotNull(groups = {DeleteGroup.class})
	private String frNo;
	@NotBlank
	private String faciNo;
	
	private int No;
	
	private String commNo;
	private String commName;
	
	private String faciName;
	
	@NotBlank
	private String memNo;

	private String ftNo;
	
	private List<String> ftNoList; // 다중선택한 ftNo 값을 저장할 리스트 
	
	
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate frDate;
	
	@NotNull
	private int frNop;
	private String frPurpose;
	
	private String frState;
}
