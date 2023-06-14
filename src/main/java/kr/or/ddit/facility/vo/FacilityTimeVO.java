package kr.or.ddit.facility.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "ftNo")
public class FacilityTimeVO implements Serializable{
	
	@NotBlank
	private String ftNo;     // 예약가능시간번호
	
	@NotBlank
	private String ftDay;	 // 예약가능 일자
	
	@NotBlank
	private String ftPeriod; // 예약가능 시간
}
