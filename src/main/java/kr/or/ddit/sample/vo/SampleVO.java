package kr.or.ddit.sample.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "sampleId")
public class SampleVO implements Serializable {
	@NotNull(groups = {UpdateGroup.class, DeleteGroup.class})
	private int sampleId;
	@NotBlank
	private String sampleName  ;
}
