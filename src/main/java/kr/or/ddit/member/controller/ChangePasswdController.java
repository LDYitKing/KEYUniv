package kr.or.ddit.member.controller;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.service.MemberService;
import kr.or.ddit.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 비밀번호 변경
 * @author PC-02
 *
 */
@Slf4j
@Controller
@RequestMapping("/member/changePasswd.do")
public class ChangePasswdController {
	
	@Inject
	MemberService service;
	   
//   @Inject
//   @Named("passwordEncoder")
//   private PasswordEncoder encoder;
	@Resource(name = "authenticationProvider")
	private AuthenticationProvider provider;
   

	@GetMapping
	public String getUI() {
		return "member/passwdForm";
	}
	
	@PostMapping
	public String changePasswd(Authentication authentication, MemberVO member, RedirectAttributes attributes) {
		// 1. 비밀번호 재확인 하기
		// 1) 로그인된 아이디와 (비밀번호 재확인하기 위해)입력 받은 비밀번호로 token을 만들어서
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(authentication.getName(), member.getCheckMemPass());
		
		try {
			// 2) security에서 인증하기
			// 예외 발생 안하면 인증 성공, 예외 발생하면 인증 실패
			provider.authenticate(token);
			
			// 2. 새 비밀번호로 변경
			member.setMemNo(authentication.getName());
			String newMemPass = member.getMemPass();
			service.modifyMemberPasswd(member);
			
			log.info("비밀번호 변경 완료 : {}", member.getMemPass());

			// 3. 로그인 중인 member의 수정된 정보(비밀번호)를 security authenication 에 반영하기 
			// (비밀번호는 AuthenticationManager에 erase-credentials="true"가 기본값으로 되어 있어 인증이 끝나고 들고다니지 않아서 따로 다시 반영해주지 않아도 된다.)
			UsernamePasswordAuthenticationToken newToken = new UsernamePasswordAuthenticationToken(authentication.getName(), newMemPass);
			Authentication auth = provider.authenticate(newToken);
			SecurityContextHolder.getContext().setAuthentication(auth);

			log.info("auth 변경된 정보 반영");
			
			attributes.addFlashAttribute("message", "비밀번호가 변경되었습니다.");
			attributes.addFlashAttribute("messageIcon", "success");
			return "redirect:/";
			
		}catch (AuthenticationException e) { // 인증 실패
			e.printStackTrace();
			
			attributes.addFlashAttribute("msg", "비밀번호를 다시 확인해주세요.");
			return "redirect:/member/changePasswd.do";
		}
		
	}
}


