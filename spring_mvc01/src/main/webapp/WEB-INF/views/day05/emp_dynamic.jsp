<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	width:1000px;
	border-collapse: collapse;
	margin: 10px suto;
}
table,th,td{
border: 1px solid black;
text-align: center;
padding : 10px;
}
h1 {
	text-align: center;
}
th{
width:20%;}
</style>
</head>
<body>
<c:choose>
	<c:when test="${idx == 1}"> <h1> 사번 검색 결과 </h1></c:when>
	<c:when test="${idx == 2}"> <h1> 이름 검색 결과 </h1></c:when>
	<c:when test="${idx == 3}"> <h1> 직종 검색 결과 </h1></c:when>
	<c:when test="${idx == 4}"> <h1> 부서 검색 결과 </h1></c:when>
</c:choose>
 <h2>인원 : ${list.size()}</h2>
<h1>전체 사원 목록 (${list.size()}명)</h1>
	<table>
		<thead>
			<tr>
				<td>번호</td>
				<td>사번</td>
				<td>이름</td>
				<td>직종</td>
				<td>부서</td>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty list}">
					<tr>
						<td colspan="5">자료가 존재하지 않습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="k" items="${list}" varStatus="vs">
						<tr>
							<td>${vs.count}</td>
							<td>${k.empno}</td>
							<td>${k.ename}</td>
							<td>${k.job}</td>
							<td>${k.deptno}</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</body>
</html>