package kr.or.ddit.curri.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(exclude = "cbContent")
public class CurriBoardVO implements Serializable {
	
	private int rnum;
	
	private String cbNo;
	private String cbTitle;
	
	private String cbWriter; // 작성자 아이디(학번/사번)
	private String memName; // 작성자 이름
	
	private String cbContent;
	private Integer cbCnt;
	
	@DateTimeFormat(iso = ISO.DATE_TIME)
	@JsonFormat(shape = Shape.STRING, pattern = "yyyy-MM-dd")	
	private LocalDateTime cbWdate;
	
	private String curriNo; // 나의 커리 번호
	
	private List<TagVO> tagList; // 태그 리스트 - select
	private List<String> tagContent; // 태그 내용 리스트 - insert
	
	private String tag; // 태그 검색
	
}



