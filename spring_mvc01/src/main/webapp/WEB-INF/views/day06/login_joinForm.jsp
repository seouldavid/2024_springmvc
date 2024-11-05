<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <h2>회원가입</h2>
	<form method="post" action="/login_join_ok">
		<table>
			<thead> <!-- 테이블 헤더 설정 -->
				<tr>
					<th>아이디</th>
					<th>패스워드</th>
					<th>이름</th>
					<th>나이</th>
				</tr>
			</thead>
			<tbody><!--테이블 바디 설정  -->
				<tr>
					<td><input type="text" size="14" name="m_id"  required><br> <!-- 아이디를 넣을 곳  -->
					<td><input type="password" size="10" name="m_pw"  required></td> <!-- 패스워드를 넣을 곳 -->
					<td><input type="text" size="14" name="m_name"  required></td><!-- 네임 텍스트를 넣을 곳 -->
					<td><input type="number" size="14" name="m_age" required></td><!-- 나이 텍스트를 넣을 곳 -->
				</tr>
			</tbody> 
			<tfoot>  <!-- 테이블 푸터 설정 -->
				<tr>
					<td colspan="4" align="center">
					<input type="submit" value="가입하기"></td> 
				</tr>
			</tfoot>
		</table>
	</form>
</body>
</html>