package kr.or.ddit.member.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.vo.MailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member/sendMail.do")
public class SendMailController {

//	private static String user = "keyuniv3@gmail.com";
//	private static String password = "iagorkupoylyloud";

	@Value("#{appInfo.user}")
	private String user;
	@Value("#{appInfo.password}")
	private String password;
	
	
	@PostMapping
	@ResponseBody
	public void sendMail(@RequestBody MailVO mailVO, HttpServletResponse resp) throws IOException {
//      log.info("mailVO : {}", mailVO );

		resp.getWriter().print("Sending simple email.");
		sendSimpleMail(mailVO);
	}

	private void sendSimpleMail(MailVO mailVO) {
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", 465);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		prop.put("mail.smtp.ssl.protocols", "TLSv1.2");

//		Session session = Session.getDefaultInstance(prop, null);
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
		try {
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user, "keyuniv3"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(mailVO.getReceiver()));
			msg.setSubject(mailVO.getTitle());
			msg.setText(mailVO.getContent());
			Transport.send(msg);
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
}