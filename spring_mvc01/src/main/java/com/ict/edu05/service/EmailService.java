package com.ict.edu05.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
@Service
public class EmailService {
	@Autowired
	private JavaMailSender javaMailSender; //자바 메인 센더 인스턴스를 생성

	// Controller 에서 호출할 메서드 생성
	public void sendEmail(String randomNumber, String toMail) { // 메일을 보낼때 랜덤 넘버를 생성한 것을 메일과 함께 매개변수로 가지고 온다.
		try {
			EmailHandler sendMail = new EmailHandler(javaMailSender); //이메일 헨들러이다 자바메일 센더 인스턴스롤 초기화 한다.
			
			//메일 제목
			sendMail.setSubject("[ICT EDU 인증 메일입니다.]"); // 이메일 헨들러 인스턴스로 메세지 헬퍼 메서드를 간편하게 사용한다.
			
			//내용
			sendMail.setText("<table><tbody>" //텍스트를 설정한다.
					+"<tr><td><h2>ICT EDU 인증</h2></td></tr>"
					+"<tr><td><h3>ICT EDU</h3></td></tr>"
					+"<tr><td><font size='8px'>인증 번호 안내</font></h3></td></tr>"
					+"<tr><td><font size='10px'>확인 번호 : "+randomNumber+"</font></h3></td></tr>"
					+"</tbody></table>");
			 // 보낼 사람의 이메일과 제목
			sendMail.setFrom("ictedu@gmail.com", "ict 관리자"); // 전부 캡슐화를 해서 내부의 복잡한 알고리즘을 생각하지 않아도 되게 했다.
			
			//받는 이메일
			sendMail.setTo(toMail); // 수신자 설정
			sendMail.send(); // 메일 보내기
		} catch (Exception e) {
			
		}
	}
}
