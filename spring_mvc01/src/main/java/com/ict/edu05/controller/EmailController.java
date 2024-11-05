package com.ict.edu05.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ict.edu05.service.EmailService;

@Controller
public class EmailController {
	@Autowired
	private EmailService emailService; // 이메일 서비스 변수 선언
	
	@GetMapping("/email")
	public  ModelAndView sendForm() {
		return new ModelAndView("day05/email_form");
	}
	
	@PostMapping("/email_send")
	public ModelAndView sendMail(
			@RequestParam("email") String email,
			HttpServletRequest request
			) {
		try {
			ModelAndView mv = new ModelAndView("day05/email_form"); // 모델엔 뷰 오브젝트 생성 day05/이메일 폼으로가 는 주소롤 초깃 값 설정
			// 임시번호 6자리 만들기
			Random random = new Random(); // 렌덤 인스턴스 생성
			String randomNumber = String.valueOf(random.nextInt(1000000)); //인스턴스 메서드로 1000000만 에서 0까지의 값을 리턴한 후 스트링으로 반환
			if (randomNumber.length() < 6) { // 만약 6자리가 아닌경우 
				int substract = 6 - randomNumber.length(); // 남은 자리수 계산
				StringBuffer sb = new StringBuffer(); // 스트링 버퍼 인스턴스 생성
				for(int i=0; i< substract; i++) { // 남은 자리수 만큼 앞에 0을 붙인다.
					sb.append("0");
				}
				sb.append(randomNumber); //뒷자리에 원래 값을 붙인다.
				randomNumber =sb.toString(); // 스트링으로 변환
			}
			// 임시번호 서버에 출력
			System.out.println("임시번호 : " + randomNumber);
			// 해당 임시번호를 DB에 저장하기 또는 세션에 저장하기
			request.getSession().setAttribute("sessionNumber", randomNumber); //세션을 불러  sessionnumber라는 	변수에 저장한다.
			
			// EmailService 호출해서 사용하기
			emailService.sendEmail(randomNumber, email); // 이메일 서비스 인스턴스를 사용해  랜덤 넘버와 이메일을 담는다.
			return mv; //이메일 폼으로 돌아가게 된다.
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			return null;
		}
	}
	
	@PostMapping("email_send_chk") // 이메일 인증 코드를 확인하는 버튼을 눌렀을때 이 컨트롤러로 오게 된다.
	public ModelAndView sendMailChk(@RequestParam("authNumber") String authNumber, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("day05/email_form");//이메일 폼으로 돌아가게 된다.
		String sessionNumber = (String) request.getSession().getAttribute("sessionNumber"); //세션에 저장된 세션 렌덤넘버를 받는다.
				
		if (authNumber.equalsIgnoreCase(sessionNumber)) { //세션넘버와 인풋에 적은 넘버가 일치할때  조건문이 성립하게 된다.
			mv.addObject("chkEmail", "인증번호 일치");// 그러면 chkemail에 값을 가지고 돌아온다.
		}
		return mv;
	}
	
}
