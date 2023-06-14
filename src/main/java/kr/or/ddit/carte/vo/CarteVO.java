package kr.or.ddit.carte.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class CarteVO implements Serializable{
	private String carteNo;
	private String carteDate;
	private String carteDay;
	private String lunchMenu;
	private String dinnerMenu;
	private String lunchMenu2;
	private String dinnerMenu2;
}
