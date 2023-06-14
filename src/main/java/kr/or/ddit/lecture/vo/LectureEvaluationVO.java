package kr.or.ddit.lecture.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;

import kr.or.ddit.validate.DeleteGroup;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="lectEvalNo")
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class LectureEvaluationVO implements Serializable{
	@NotBlank(groups = DeleteGroup.class)
	private String lectEvalNo;
	@NotBlank
	private String courseNo;
	@NotBlank
	private String lectNo;
	private String lectName;
	@NotBlank
	private String stuNo;
	private String leaNo;
	@NotBlank
	private String leAnswer;
	
	private LectEvalArtiVO lea; // has a 관계
	
	private List<LectureEvaluationVO> lectEvalList; // 나 리스트
}
