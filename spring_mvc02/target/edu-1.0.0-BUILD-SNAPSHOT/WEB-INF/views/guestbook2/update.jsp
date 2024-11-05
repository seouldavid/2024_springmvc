<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방 명 록</title>
<link rel="stylesheet" href="resources/css/summernote-lite.css"><!-- 써머노트 라이트 css를 불러온다 -->

<style type="text/css">
a {
	text-decoration: none;
}

table {
	width: 600px;
	border-collapse: collapse;
	text-align: center;
}

table, th, td {
	border: 1px solid black;
	padding: 3px
}

div {
	width: 600px;
	margin: auto;
	text-align: center;
}
.note-btn-group {
	width: auto;
}
</style>
</head>
<body>
	<div>
		<h2>방명록 : 작성화면</h2>
		<hr>
		<p>
			<a href="/gb2_list">[목록으로 이동]</a>
		</p>
		<form method="post" enctype="multipart/form-data" action="/gb2_update_ok">
			<table>
				<tr align="center">
					<td bgcolor="#99ccff">작성자</td>
					<td><input type="text" name="gb2_name" size="20"
						value="${gb2VO.gb2_name }"></td>
				</tr>
				<tr align="center">
					<td bgcolor="#99ccff">제 목</td>
					<td><input type="text" name="gb2_subject" size="20"
						value="${gb2VO.gb2_subject }"></td>
				</tr>
				<tr align="center">
					<td bgcolor="#99ccff">email</td>
					<td><input type="text" name="gb2_email" size="20"
						value="${gb2VO.gb2_email }"></td>
				</tr>
				<tr align="center">
					<td bgcolor="#99ccff">첨부파일</td>
					<c:choose>
						<c:when test="${empty gb2VO.gb2_f_name }">
							<td><input type="file" name="gb2_file_name"><b>이전
									파일 없음</b></td>
						</c:when>
						<c:otherwise>
							<td><input type="file" name="gb2_file_name"><!-- 수정한다면 gb2_file_name으로 보낸다. --><b>이전파일 (${gb2VO.gb2_f_name})</b> <input type="hidden" name="old_f_name" value="${gb2VO.gb2_f_name}"></td> <!-- 현재 vo의 파일이름이 숨겨져 있다 이것을 old_f_name으로 보낸다. -->
						</c:otherwise>
					</c:choose>
				</tr>
				<tr align="center">
					<td bgcolor="#99ccff">비밀번호</td>
					<td><input type="password" name="gb2_pw" size="20"></td>
				</tr>
				<tr align="center">
					<td colspan="2"><textarea rows="10" cols="60" name="gb2_content" id="gb2_content">${gb2VO.gb2_content }</textarea>
					</td>
				</tr>
				<tfoot>
					<tr align="center">
						<td colspan="2"><input type="hidden" name="gb2_idx"
							value="${gb2VO.gb2_idx}"> 
							<input type="submit" value="수정완료" > 
							 <input type="reset" value="취소"></td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"
		crossorigin="anonymous"></script> <!-- 제이쿼리 문을 임포트 한다. -->
	<script src="resources/js/summernote-lite.js"></script> <!-- 써머노트 라이트 js를 가져온다. -->
	<script src="resources/js/lang/summernote-ko-KR.js"></script><!-- 한글용을 가져온다. -->
	<script type="text/javascript">
		$(function() {
			$("#gb2_content").summernote({/*해당 쿼리 셀렉트를 하고 서머노트 메서드를 사용한다.  */
				lang : 'ko-KR', /* 한글지원 */
				height : 300, /* 크기 지정 */
				focus : true, /* 포커스 설정  */
				placeholder : "최대 3000자까지 쓸 수 있습니다.", /* 시작 구문 설정 */
				callbacks : { /* 함수 설정 */
					onImageUpload : function(files, editor) { /* 서머노트를 이용해 이미지가 업로드 되면 발생하는 함수 */
						for (var i = 0; i < files.length; i++) {
							sendImage(files[i], editor); /* 각 업로드 된 파일 마다 사용자 정의 함수를 사용한다. */
						}
					}
				}
			});
		});

		function sendImage(file, editor) {/*  */
			//FormData 겍체를 전송할때 , jQuery가 설정
			let form = new FormData();/*비동기로 파일을 전송하기 위한 폼데이터 인스턴스 생성  */
			form.append("s_file", file); /* 파일을 s_file 변수에 저장한다. */
			$.ajax({/* 아약스로 비동기 방식으로 파일을 전송한다. */
				url : "/saveImg",/*saveImg라는 url이 있는 컨트롤러로 매핑한다.  */
				data : form, /* 폼데이터를 이동시킨다.  */
				method : "post",/*포스트 방식으로 이동시킨다.*/
				contentType: false, /* 콘텐츠 타입 자동 설정 */
				processData: false,/*원본 그대로 */
				cache : false,/*캐싱 설정 안함  */
				dataType : "json",/*응답 받을때 json 형식으로 받는다. */
				success : function(data) {/*해시맵을 json으로 변환한다.  */
					const path = data.path;/*  경로 추출 */
					const fname = data.fname;/* 파일 이름을 추출 */
					console.log(path,fname)
					$("#gb2_content").summernote("editor.insertImage",
							path + "/" + fname);/*경로와 파일이름을 엮고 insertimage 매서드를 실행한다.  */

				},
				error : function(){
					alert("읽기 실패");
				},
			})
		}
	</script>

</body>
</html>