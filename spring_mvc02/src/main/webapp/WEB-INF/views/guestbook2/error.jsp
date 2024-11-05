<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>error</title>
</head>
<body>
  <h1>공 사 중</h1>
  <form action= "${pageContext.request.contextPath}/GuestBook2Controller" method="post" enctype="multipart/form-data">
			<input type="submit" value="확인">
			<input type="hidden" name="cmd" value="gb2_list">
		</form>
</body>
</html>