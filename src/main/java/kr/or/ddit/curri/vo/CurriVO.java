package kr.or.ddit.curri.vo;

import java.sql.Timestamp;
import java.util.List;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class CurriVO {
	@NotBlank
	private String curriNo;
	@NotBlank
	private String curriDesigner;
	@NotBlank
	private String curriName;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Timestamp curriRdate;
	private List<CurriDetailVO> curriDetail;
	private int rnum;
}
