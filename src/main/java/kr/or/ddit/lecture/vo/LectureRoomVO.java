package kr.or.ddit.lecture.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="lrNo")
public class LectureRoomVO implements Serializable{
	private String lrNo;
	private String builNo;
	private String deptNo;
	private String colNo;
	private String lrNum;
	private Integer lrMnop;
}
