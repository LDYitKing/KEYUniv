package kr.or.ddit.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.MemberVOWrapper;

@Mapper
public interface MemberDAO extends UserDetailsService{
   @Override
   default UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
      MemberVO member = selectMember(username);
      return new MemberVOWrapper(member);
   }
   
   public MemberVO selectMember(String memNo);
   
   public List<MemberVO> searchId(MemberVO member);
   
   public MemberVO searchPasswd(MemberVO member);
   
//   public int updateMember(MemberVO member);
   // 비밀번호 변경 - 임시 비밀번호 발급, 개인 비밀번호 변경
   public int updateMemberPasswd(MemberVO member);
   
   public int insertMember(MemberVO member);
   
   public int updateMember(MemberVO member); 
   
   public List<MemberVO> selectMemberList();
  
}