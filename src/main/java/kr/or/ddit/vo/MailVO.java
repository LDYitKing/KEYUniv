package kr.or.ddit.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class MailVO implements Serializable {
	private String receiver; // 수신자
	private String title; // 메일제목
	private String content; // 메일내용
	
	private boolean successYn;
}
