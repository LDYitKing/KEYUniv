package kr.or.ddit.lecture.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;

import kr.or.ddit.validate.DeleteGroup;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="leaNo")
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class LectEvalArtiVO implements Serializable{
	@NotBlank(groups = DeleteGroup.class)
	private String leaNo;
	private String leaQue;
	private String leaContent;
	
	private String avgAnswer;
}
