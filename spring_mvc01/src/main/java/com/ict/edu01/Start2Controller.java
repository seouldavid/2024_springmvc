package com.ict.edu01;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class Start2Controller implements Controller {
	public Start2Controller() {
		// TODO Auto-generated constructor stub
		System.out.println("start2Controller");
	}
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		// 방법1)
		// ModelAndView mv = new ModelAndView();
		// mv.setViewName(뷰네임 = 되돌아갈 jsp 이름 ="result1");
		mv.setViewName("result2");

		// 방법2)
		// ModelAndView mv = new ModelAndView("result1");
		String[] dogName = { "땅콩이", "진돌이", "말복이", "하오" };
		mv.addObject("dogName", dogName);

		ArrayList<String> catNames = new ArrayList<String>();
		catNames.add("뽀삐");
		catNames.add("나비");
		catNames.add("달콩이");
		catNames.add("까망이");
		mv.addObject("catNames", catNames);

		return mv;
	}
}