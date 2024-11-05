<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>비밀번호 받을 이메일을 넣어주세요</h2>
	<form action="/email_send" method="post"> <!-- 이메일 보내기로 보내기 -->
		<input type="email" name="email" 
			pattern="[a-zA-Z0-9]+[@][a-zA-Z0-9]+[.]+[a-zA-Z]+[.]*[a-zA-Z]*"
			title="이메일 양식" required> <input type="submit" value="전송"><!-- 이메일 타입 인풋 태그를 사용. 패턴은 대소문자숫자 하나이상 @ 대소문자 숫자 하나이상 점 하나이상 대소문자 하나이상 추가로 점 대소문자 0개 이상 .-->
	</form>
	<form action="/email_send_chk" method="post">	<!-- 이메일 보내기 체크 컨트롤러로 보내기 -->
		<input type="number" name="authNumber" id="authNumber" 
			placeholder="인증번호" maxlength="6" required> <!-- 인풋타입은 숫자이고 네임과 아이디는 authnumber이다. placeholder는 인증번호이고 최대길이는 6이다. --> 
			<input type="submit" value="전송"> <!-- 전송하기 -->
	</form>
	<script type="text/javascript">
	<c:if test="${!empty chkEmail}"> /*jstl로 chkEmail이 일치하다는 값을 가지지 아니할 경우 일치하다는 문은 나오지 않게 된다.  */
	alert("일치합니다.")
	</c:if>
		function authNum() {
			const number = document.querySelector("#authNumber").value; // authnumber에 적인 값을 불러온다.
			if (authNumber.length !== 6 || isNaN(authNumber)) { //만약 그값이 6자리가 아닐경우 혹은 넘버가 아닐경우
				alert("6자리 숫자만 입력해야 합니다."); //다시입력하라는 경고창을 띄우게 되고
				return false; // 폼 제출을 중단하게 된다.
			}
			return true; // 위 인증번호제출 조건을 충족시 true를 리턴한다.
		}
	</script>
</body>
</html>