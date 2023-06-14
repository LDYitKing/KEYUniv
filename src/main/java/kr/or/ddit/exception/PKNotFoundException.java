package kr.or.ddit.exception;

/**
 * PK 로 상세조회시 해당 레코드가 없는 경우, 발생하는 예외.
 *
 */
public class PKNotFoundException extends RuntimeException {

	public PKNotFoundException(String pk) {
		super(String.format("%s 에 해당하는 데이터가 존재하지 않습니다.", pk));
	}
	
}
