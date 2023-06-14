package kr.or.ddit.sch;

public class SchException  extends RuntimeException{
	
	public SchException(int schNo) {
		super(String.format("%d 번의 글에 문제가 생겼음.", schNo));
	}
	
}
