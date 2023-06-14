package kr.or.ddit.curri.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;

@Data
public class CurriCommentVO implements Serializable{
	private String ccNo;
	private String cbNo;
	private String ccContent;
	private String ccWriter; // 작성자 이름
	private String memNo; // 작성자 아이디
	
	@DateTimeFormat(iso = ISO.DATE_TIME)
	@JsonFormat(shape = Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime ccWdate;
}
