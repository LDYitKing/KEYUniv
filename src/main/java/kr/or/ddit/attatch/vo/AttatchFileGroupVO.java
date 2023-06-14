package kr.or.ddit.attatch.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "atchId")
public class AttatchFileGroupVO {
	private Integer atchId; // 파일 그룹 아이디
	
	private int[] delSeqs; // 지울 파일의 순서번호'들'
	
	private int startSeq; // 파일을 추가하는 경우 첫번째 순서번호
	
	private List<AttatchFileVO> atchfileList;
}
