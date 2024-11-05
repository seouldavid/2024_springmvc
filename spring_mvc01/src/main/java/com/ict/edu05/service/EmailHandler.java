package com.ict.edu05.service;
//Service에서 호출해서 사용할 클래스

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class EmailHandler {
	
private JavaMailSender javaMailSender;	
private MimeMessage message;
private MimeMessageHelper messageHelper;
	
	public EmailHandler(JavaMailSender javaMailSender) throws Exception { //헨들러는 생성자에 인자가 꼭 들어가야 한다.
		this.javaMailSender = javaMailSender; //자바 메일센더 초기화
		
		message = this.javaMailSender.createMimeMessage(); //자바메일센더의 createMImeMessage메서드를 사용한다 클라이언트가 메세지를 전송할 준비를 하게 된다.
		//true => 멀티파트 메세지 지원 사용가능
		messageHelper = new MimeMessageHelper(message,true,"UTF-8"); //인코딩 방식을 설정한다. true를 쓰면 첨부파일 도 사용가능하게 한다.
		
		// 단순한 텍스트 메세지만 사용
		//messageHelper = new MimeMessageHelper(message,"UTF-8");
	}
	// 제목
	public void setSubject(String subject) throws Exception{
		messageHelper.setSubject(subject); // 제목을 세터한다.
	}
	// 내용
	public void setText(String text) throws Exception{
		
		messageHelper.setText(text,true);
	}
	// 보낸 사람의 이메일과 제목
	public void setFrom(String email,String name) throws Exception{
		messageHelper.setFrom(email,name);
	}
	// 받는 이메일
	public void setTo(String email) throws Exception{
		messageHelper.setTo(email);
	}
	// 보내기
	public void send() {
		javaMailSender.send(message);
	}
}
