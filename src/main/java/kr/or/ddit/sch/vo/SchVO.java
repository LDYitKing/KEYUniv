package kr.or.ddit.sch.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="schNo")
public class SchVO implements Serializable {
// 기본 컬럼
	@NotNull(groups = {UpdateGroup.class , DeleteGroup.class})
	private String schNo;
	@NotBlank
	private String schName;
	@NotNull // int 타입은 notNull로 표시
	private int schAmount;
	@NotBlank
	private String schCont;
	@NotBlank
	private String schReq;
	
	
}
