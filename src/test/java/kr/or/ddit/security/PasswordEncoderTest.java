package kr.or.ddit.security;

import org.junit.Test;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.or.ddit.AbstractModelLayerTest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PasswordEncoderTest extends AbstractModelLayerTest {
//	@Inject
	private PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
	
	@Test
	public void encodeTest() {
		String plain = "asdf@123";
		String encoded = encoder.encode(plain);
		log.info("encoded password : {}", encoded);
		
		String saved = "{bcrypt}$2a$10$mWaFbWr2Dy3.tTpQypDkRONwvv1If39UJ3Kk7KWb.okBG8UCq4iNy";
		log.info("인증 성공 여부 : {}", encoder.matches(plain, saved));
	}
}
