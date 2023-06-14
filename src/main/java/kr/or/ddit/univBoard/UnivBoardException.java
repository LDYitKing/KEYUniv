package kr.or.ddit.univBoard;

public class UnivBoardException  extends RuntimeException{
	
	public UnivBoardException(int ubNo) {
		super(String.format("%d 번의 글에 문제가 생겼음.", ubNo));
	}
	
}
