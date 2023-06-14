package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.vo.MailVO;

public interface MemberService {

	/**
	 * 학번/사번과 생년월일로 아이디 찾기
	 * @param member
	 * @return
	 */
	public List<MemberVO> searchId(MemberVO member);

	/**
	 * 아이디와 이메일을 입력 받아 임시 비밀번호를 발급하는 메일 보내기
	 * @param member
	 * @return
	 */
	public MailVO searchPasswd(MemberVO member);

	/**
	 * 비밀번호 변경
	 * @param member
	 * @return
	 */
	public int modifyMemberPasswd(MemberVO member);
}