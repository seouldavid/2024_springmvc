package com.ict.guestbook2.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.guestbook2.service.GuestBook2Service;
import com.ict.guestbook2.vo.GuestBook2VO;

@Controller
public class GuestBook2Controller {
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private GuestBook2Service guestBook2Service;

	@GetMapping("/gb2_list") //
	public ModelAndView guestBookList() {
		ModelAndView mv = new ModelAndView("guestbook2/list");
		List<GuestBook2VO> list = guestBook2Service.getGuestBook2List();
		mv.addObject("gb2_list", list);
		return mv;
	}

	@GetMapping("/gb2_write")
	public ModelAndView guestBookWrite() {
		return new ModelAndView("guestbook2/write");
	}

	@GetMapping("/gb2_detail")
	public ModelAndView guestBookDetail(/*@RequestParam("gb2_idx")*/ String gb2_idx) { //
		ModelAndView mv = new ModelAndView("guestbook2/onelist");
		GuestBook2VO gb2vo = guestBook2Service.getGuestBook2Detail(gb2_idx);
		if (gb2vo != null) {
			mv.addObject("gb2VO", gb2vo);
			return mv;
		}
		return new ModelAndView("guestbook2/error");
	}

	@PostMapping("/gb2_write_ok")
	public ModelAndView guestBook2WriteOk(GuestBook2VO gb2vo, HttpServletRequest request) {

		try {

			ModelAndView mv = new ModelAndView("redirect:/gb2_list");

			// 파일 정보
			// System.out.println("파일정보 : " +
			// gb2vo.getGb2_file_name().getOriginalFilename());

			// 써머 노트 정보까지
			// System.out.println("썸머노트 정보 : " + gb2vo.getGb2_content());
			// 삽입
			String path = request.getSession().getServletContext().getRealPath("resources/upload");//컨텍스트경로에 있는 리소스 업로드 폴더의 주소를 스트링으로 반환한다. 
			MultipartFile file = gb2vo.getGb2_file_name();// 폼에서 가져온 파일 이름을 멀티파트 파일 타입으로 반환한다.

			if (file.isEmpty()) { //파일이 없거나 내용이 없으면
				gb2vo.setGb2_f_name("");// vo의 파일 이름을 공백으로 한다.
			} else { //만약 파일이 있다면
				UUID uuid = UUID.randomUUID(); // uuid 넘버를 만든다.
				String f_name = uuid.toString() + "_" + file.getOriginalFilename(); //uuid_파일이름 형식으로 반환한다.
				gb2vo.setGb2_f_name(f_name); //폼 데이터의 vo의 파일네임을 uuid 형식으로 set 한다.

				file.transferTo(new File(path, f_name));// 파일이름이 포함된 경로를 파일 인스턴스로 초기화한다. 멀티파트 객체를  지정된 경로+ uuid 파일 경로로 이동한다.
			}

			// 비밀번호 암호화
			String pwd = passwordEncoder.encode(gb2vo.getGb2_pw()); // 폼에서 가져온 숫자 비밀번호를 해석이 어려운 코드로 변환한다.
			gb2vo.setGb2_pw(pwd);// 인코딩된 패스워드를 vo에 수정한다.

			int result = guestBook2Service.getGuestBook2Insert(gb2vo);// 다수정된 vo를 insert한다.
			if (result > 0) {
				return mv; // insert 성공하면 모델 뷰 객체를 반환 리다이렉트한다.
			}

			return new ModelAndView("guestbook2/error");
		} catch (Exception e) {
			System.out.println(e);
			return new ModelAndView("guestbook2/error");
		}
	}

	@GetMapping("/guestbook2_down")
	public void guestBook2Down(HttpServletRequest request, HttpServletResponse response) {
		try {
			String f_name = request.getParameter("f_name"); //파일이름을 폼에서 가져온
			String path = request.getSession().getServletContext().getRealPath("/resources/upload/" + f_name);//실제 저장경로를 불러오고 파일이름을 앾는다.
			String r_path = URLEncoder.encode(path, "UTF-8"); // 파일 이름만 인코딩한다.
//			시험에 나옴
			// 브라우저 설정
			response.setContentType("application/x-msdownload"); // response 객체를 이용해 다운로드를 가능하게 설정한다.
			response.setHeader("Content-Disposition", "attachment; filename=" + r_path);//다운로드 형식으로 설정

			File file = new File(new String(path.getBytes(), "utf-8"));//파일 이름이 포함된 경로를 바이트배열로 변환뒤 utf-8방식이 재변환 합니다. 그리고 파일 객체로 초기화합니다.
			FileInputStream in = new FileInputStream(file); //파일 객체를 파일 인풋 스트림으로 변환한다.

			OutputStream out = response.getOutputStream(); // 설정된 response 객체의 아웃풋 스트림으로 반환한다.

			FileCopyUtils.copy(in, out);//인풋 스트림의 데이터를 아웃풋 스트림으로 출력한다.
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	@PostMapping("/gb2_delete")
	public ModelAndView guestbook2Delete(@ModelAttribute("gb2_idx") String gb2_idx) {//gb2_idx를 모뎅 어트리뷰트에 넣으면 뷰로 가져갈 수 있다.
		return new ModelAndView("guestbook2/delete");
	}

	@PostMapping("/gb2_delete_ok")
	public ModelAndView guestbook2DeleteOK(GuestBook2VO gb2vo) {
		ModelAndView mv = new ModelAndView();

		// 비밀번호가 맞는지 검사
		GuestBook2VO gb2vo2 = guestBook2Service.getGuestBook2Detail(gb2vo.getGb2_idx());// idx로 객체 select 결과는 거의 반드시 나온다.

		// jsp에서 입력한 password ( 암호화 X)
		String pw = gb2vo.getGb2_pw(); //폼에 입력한 패스워드를 꺼낸다.

		// DB에서 가져온 password ( 암호화 O)
		String pw2 = gb2vo2.getGb2_pw();//DB에서 가져온 패스워드를 꺼낸다.

		if (passwordEncoder.matches(pw, pw2)) { //패스워드 앤코더에 pw pw2가 서로 매칭되는지 확인한다. 펏번째는 raw 두번째는 인코딩된 패스워드이다.
			int result = guestBook2Service.getGuestBook2Delete(gb2vo.getGb2_idx());// 매칭된다면 해당하는 idx를 이용해 삭제를 한다.
			if (result > 0) {
				mv.setViewName("redirect:/gb2_list");//성공하면 리스트로 리다이렉트를 한다.
				return mv;
			}
		} else {//다르다면 idx와 pwdch를 가지고 다시 delete 로 가게 된다.
			mv.setViewName("guestbook2/delete");// delete 페이지로 이동하도록 지시
			mv.addObject("pwdchk", "fail"); //
			mv.addObject("gb2_idx", gb2vo.getGb2_idx());
			return mv;
		}

		return new ModelAndView("guestbook2/delete");
	}

	@PostMapping("/gb2_update")
	public ModelAndView guestbook2Update(@RequestParam("gb2_idx") String gb2_idx) { //idx
		ModelAndView mv = new ModelAndView("guestbook2/update");
		GuestBook2VO gb2VO = guestBook2Service.getGuestBook2Detail(gb2_idx);
		if (gb2VO != null) { //vo를 가지고 update로 간다.
			mv.addObject("gb2VO", gb2VO);
			return mv;
		}
		return new ModelAndView("guestbook2/error");
	}

	@PostMapping("/gb2_update_ok")
	public ModelAndView guestbook2UpdateOK(GuestBook2VO gb2vo, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();

		// 비밀번호가 맞는지 검사
		GuestBook2VO gb2vo2 = guestBook2Service.getGuestBook2Detail(gb2vo.getGb2_idx());

		// jsp에서 입력한 password ( 암호화 X)
		String pw = gb2vo.getGb2_pw();

		// DB에서 가져온 password ( 암호화 O)
		String pw2 = gb2vo2.getGb2_pw();

		if (passwordEncoder.matches(pw, pw2)) {

			try {
				String path = request.getSession().getServletContext().getRealPath("/resources/upload");
				MultipartFile file = gb2vo.getGb2_file_name(); //update 폼에서 가져온 데이터를 멀티파트 객체에 담는다. 
				String old_f_name = gb2vo.getOld_f_name(); // 교체되기 전의 파일 이름을 담는다.

				if (file.isEmpty()) {
					gb2vo.setGb2_f_name(old_f_name); // 만약 아무것도 넣지 않았다면 오래된 파일 이름을  f_name에 담는다.
				} else {
					UUID uuid = UUID.randomUUID(); // 만약 있다면 UUID 생성
					String f_name = uuid.toString() + "_" + file.getOriginalFilename(); // UUID_파일이름 으로 파일이면 재정리
					gb2vo.setGb2_f_name(f_name); // UUID 형식이로 파일이름 넣기

					file.transferTo(new File(path, f_name));// 경로와 파일이름을 파일 객체로 생성 후 멀티파트의 파일을 해당 경로로 이동한다.
				}

				String pwd = passwordEncoder.encode(gb2vo.getGb2_pw());//패스워드도 bcryptpassword encoder로 인코딩하고 세팅을 해준다.
				gb2vo.setGb2_pw(pwd);

				int result = guestBook2Service.getGuestBook2Update(gb2vo);//UUID 파일이름, 비밀번호 암호화를 해주고  업데이트 쿼리문을 실행한다.
				if (result > 0) {
					mv.setViewName("redirect:/gb2_detail?gb2_idx=" + gb2vo.getGb2_idx());//뷰를 세팅하여 디데일 컨트롤러로 특정 idx를 담아 리다이렉트로 이동한다.
					return mv;
				}

				return new ModelAndView("guestbook2/error");
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
				return new ModelAndView("guestbook2/error");
			}

		} else { //비밀번호가 틀렸을 경우 
			mv.setViewName("guestbook2/update"); //업데이트로 다시 이동한다.
			mv.addObject("pwdchk", "fail");// fail값을 넣어 이동
			mv.addObject("gb2_VO", gb2vo2);//vo도 함께 이동한다.
			return mv;
		}

	}
}
