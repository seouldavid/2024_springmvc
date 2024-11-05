package com.ict.guestbook2.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ict.guestbook2.vo.ImgVO;

@RestController
public class SummernoteAjaxController {

	@RequestMapping(value= "/saveImg", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,String> saveImg(ImgVO imgVO,HttpServletRequest request) { //폼데이터를 imgvo로 담는다.
		try {
			Map<String,String> map = new HashMap<String,String>();//데이터를 저장할 자료구조를 설정
			MultipartFile file =imgVO.getS_file();// imgVO에 담겨있는 multipartfile을 가져온다.
			String fname = null;
			if (file.getSize()>0) {//파일이 0byte 이상이라면
				String path = request.getSession().getServletContext().getRealPath("/resources/upload");//업로드 경로설정
				UUID uuid = UUID.randomUUID();//UUID 설정
				fname = uuid.toString() + "_" +file.getOriginalFilename();//UUID_ 파일이름
				file.transferTo(new File(path,fname));//멀티파트 파일을 해당 경로로 이동시킨다.
				
						
			}
			map.put("path", "resources/upload");//path의 값을 지정
			map.put("fname", fname); //fname에 UUID 파일이름을 지정
			return map;// 해시맵 리턴
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
	}
}
