package com.ict.sns.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.ict.sns.vo.KakaoUserResponse;
import com.ict.sns.vo.NaverUserResponse;
import com.ict.sns.vo.NaverVO;

@RestController
public class NaverUserInfoController {
	@RequestMapping(value = "/NaverUserInfo", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String NaverUserInfo(HttpServletRequest request) {
		// 세션에 저장된 kavo 안에 access_token을 이용해서 사용자 정보 가져오기
		NaverVO navo = (NaverVO) request.getSession().getAttribute("navo");
		String access_token = navo.getAccess_token();

		String apiURL = "https://openapi.naver.com/v1/nid/me";
		String header = "Bearer " + access_token;
		HttpURLConnection conn = null;
		BufferedReader br = null;
		try {
			URL url = new URL(apiURL);
			conn = (HttpURLConnection) url.openConnection();
			
			//POST
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			//conn.setRequestProperty("Content-type", "application/x")
			conn.setRequestProperty("Authorization","Bearer " + access_token);
			
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			
			if (responseCode == HttpURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				
				String line ="";
				StringBuffer sb = new StringBuffer();
				while ((line=br.readLine()) != null) {
					sb.append(line);
				}
				System.out.println(sb.toString());
				return sb.toString();
			}
			
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try {
				br.close();
				conn.disconnect();
			} catch (Exception e2) {
				System.out.println(e2);
			}
		}

		return null;
	}

	
}
