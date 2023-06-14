package kr.or.ddit.curri.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(of = "tagNo")
public class TagVO implements Serializable {
	private String tagNo;
	private String cbNo;
	private String tagContent;
	
	private int count; // 동일 태그 수
	private int rank; // 순위 몇 까지 보일지 정하기 
	
}
