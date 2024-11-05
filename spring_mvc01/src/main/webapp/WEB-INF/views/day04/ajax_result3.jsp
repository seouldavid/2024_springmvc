<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
span {
	width: 150px;
	color: red;
}

input {
	border: 1px solid red;
}

table {
	width: 80%;
	margin: 0 auto;
}

table, th, td {
	border: 1px solid lightgray;
	text-align: center;
}

h2 {
	text-align: center;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h2>Ajax를 활용한 DB처리</h2>
	<h2>회원 정보 입력하기</h2>
	<form method="post" id="myForm">
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
					<td><input type="text" size="14" name="m_id" id="m_id"><br> <!-- 아이디를 넣을 곳  -->
						<span>중복여부</span></td>
					<td><input type="password" size="10" name="m_pw" id="m_pw"></td> <!-- 패스워드를 넣을 곳 -->
					<td><input type="text" size="14" name="m_name" id="m_name"></td><!-- 네임 텍스트를 넣을 곳 -->
					<td><input type="number" size="14" name="m_age" id="m_age"></td><!-- 나이 텍스트를 넣을 곳 -->
				</tr>
			</tbody> 
			<tfoot>  <!-- 테이블 푸터 설정 -->
				<tr>
					<td colspan="4" align="center"><input type="button" value="가입하기" id="btn_join" disabled></td> <!-- 가입하기 버튼 비활성화 상태  -->
				</tr>
			</tfoot>
		</table>
	</form>
	<br>
	<br>
	<br>
	<br>
	<h2>회원 정보 보기</h2>		<!-- 실시간 dB 보기  -->
	<div>
		<table id="list">		<!-- 테이블 형성 -->
			<thead>					<!-- 헤더 -->
				<tr>
					<th>번호</th> 
					<th>아이디</th>
					<th>패스워드</th>
					<th>이름</th>
					<th>나이</th>
					<th>가입일</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="tbody"></tbody> <!-- 바디 여기에 아약스로 붙일 예정 -->
		</table>
	</div>


	<script type="text/javascript">
		// ajax를 이용해서 DB정보 가져오기 (첫 접속, 삭제, 삽입) 
		function getList() {
			$.ajax({
						url : "/ajax_db_list", /* 아약스 db list라는 url로 가게 지정 */
						method : "post", /* 방식은 post 방식이다. */
						dataType : "xml", /* 서버로부터 받을 데이터 형식을 xml로 정한다. */
						success : function(data) {/* xml 데이터를 성공적으로 받았을 때 실행할 함수 */
							// console.log(data);
							let tbody = "";/* 변수 선언 */
							$(data)
									.find("member") /* data에서 member요소들을 찾고 콜렉션으로 리턴한다. find는 계층에 제한이 없어서 members의 선택자로 쓸 필요가 없다.*/
									.each(  /* member 요소들을 대상으로 함수를 실행한다. */
											function() {
												tbody += "<tr>";
												tbody += "<td>"
														+ $(this).find("m_idx")/* 각 member 안에 태그들을 찾아 텍스트 값들을 리턴해 td 안에 쓴다.  */
																.text()
														+ "</td>";
												tbody += "<td>"
														+ $(this).find("m_id")
																.text()
														+ "</td>";
												tbody += "<td>"
														+ $(this).find("m_pw")
																.text()
														+ "</td>";
												tbody += "<td>"
														+ $(this)
																.find("m_name")
																.text()
														+ "</td>";
												tbody += "<td>"
														+ $(this).find("m_age")
																.text()
														+ "</td>";
												tbody += "<td>"
														+ $(this).find("m_reg")
																.text()
														+ "</td>";
												tbody += "<td><input type='button' value='삭제' id='member_del' name='"
														+ $(this).find("m_idx")
																.text()
														+ "'></td>";
												tbody += "</tr>";
											});
							/* 모든 memeber를 다 돌면 tobody id에 새로 만든 테이블을 리턴한다. */
							$("#tbody").append(tbody);
						},
						error : function() {
							alert("읽기실패")
						}
					});
		}

		function getList2() {
			$.ajax({
				url : "/ajax_db_list2",
				method : "post",
				dataType : "json",/*받은 데이터의 형식을 json으로 정한다.  */
				success : function(data) {
					// console.log(data);
					let tbody = "";
					$.each(data, function(index, obj) {
						tbody += "<tr>";
						//tbody += "<td>" + obj.m_idx + "</td>";
						tbody += "<td>" + obj.m_idx + "</td>";
						tbody += "<td>" + obj.m_id + "</td>";
						tbody += "<td>" + obj.m_pw + "</td>";
						tbody += "<td>" + obj.m_name + "님 </td>";
						tbody += "<td>" + obj.m_age + "살 </td>";
						tbody += "<td>" + obj.m_reg + "</td>";
						tbody += "<td>삭제</td>";
						tbody += "</tr>";
					});
					$("#tbody").append(tbody);
				},
				error : function() {
					alert("읽기실패")
				}
			});
		}

		function getList3() {
			$.ajax({
				url : "/ajax_db_list3",
				method : "post",
				dataType : "text", /* csv는 텍스트 형태로 받는다. */
				success : function(data) {
					// console.log(data);
					let rows = data.split("\n"); /* 각 row 를 요소로 배열을 만든다. */
					let tbody = "";

					$.each(rows/* 스플릿 하고 남은 배열 */, function(index, row /* 배열안에 각 요소 */) {
						// 헤더가 있으면 제외
						if (index === 0 || row.trim() === "") {/* 인덱스가 처음일때 혹은 양쪽 공백을 제거 했을 때 아무내용이 없으면 조건문을 충족 */
							return true; /* continue와 같다. */
						}

						let cols = row.split(","); /* 각 row 요소들에서 다시 , 기준으로 스플릿을 한다. */

						tbody += "<tr>"; /* 새로운 테이블에 새로운 row를 넣는다. */
						$.each(cols /* 각 row를 스플릿한 배열 */, function(i, col/* 그배열의 각 요소를 가리킨다. */) {
							tbody += "<td>" + col + "</td>";/* 새로 만든 row에 데이터를 함수에 매개변수롤 넣은 데이터를 넣는다. */
						});
						tbody += "<td>삭제</td>"; /* 각 새로운 row 끝에 삭제를 넣는다. */
						tbody += "</tr>";
					});
					$("#tbody").append(tbody);/* 모든 반복문을 다 돌고 결과물을 붙인다. */
				},
				error : function() {
					alert("읽기실패")
				}
			});
		}
		let isInputChk = false; /* 인풋 체크를 false로 한다. */
		function toggleJoinButton() { /* toggletojoin 함수를 선언 */

			const passwordFiled = $("#m_pw").val() !== ""; /* 패스워드 아이디를 가진 인풋의 값을 가져온다. 해당 값이 공란이 아니면 true 값을 넣는다. 인풋은 text를 사용할 수 없다 */

			const nameFiled = $("#m_name").val() !== ""; /* 네임 아이디를 가진 인풋의 값을 가져온다. 인풋은 text를 사용할 수 없다 */

			const ageFiled = ($("#m_age").val() !== "") /* 나이 아이디를 가진 인풋의 값을 가져온다. 인풋은 text를 사용할 수 없다 */
					&& (parseInt($("#m_age").val()) > 0); /* age를값을 int 타입으로 변환 시킨다. 그리고 0이상을 때만 true만 return 한다. */

			if (isInputChk && passwordFiled && nameFiled && ageFiled) { /* 모든 값이 다 들어가고 나이가 0 이상일 때만 조건문 안에 들어간다. */
				$("#btn_join").prop("disabled", false);/* 가입하기 버튼의 현재 disabled 상태를 false로 바꾼다. */
			} else {
				$("#btn_join").prop("disabled", true);/* 조건문을 충족하지 않는다면 가입하기 버튼의 현재 disabled 상태를 true로 바꾼다. */

			}
		}
		$("#m_id").keyup(function() { // 아이디 태그를 가지고 있는 요소에서 키보드를 땟을때 실행하는 함수
			$.ajax({
				url : "/ajax_id_chk",
				data : "m_id=" + $("#m_id").val(), // 파라미터(하나일때 사용)  / 서버에 데이터를 보낼때 사용한다. "파라미터변수=파라미터값"을 보낸다. 쿼리스트링을 생각하면 될듯하다.
				method : "post", 
				dataType : "text", //리턴할 데이터 타입이 스트링이다. 그래서 텍스트가 리턴 타입이다.
				success : function(data) {
					if (data == '1') {
						// 아이디 가 이미 db 안에 있기 때문에 사용불가를 넣어준다.
						$("span").text("사용불가");
						isInputChk = false; //인풋체크를 false를 함으로써 가입하기 버튼을 disabled true로 바꿔 준다.
					} else if (data == '0') {
						// 아이디가 없으면 select문  사용가능
						$("span").text("사용가능");
						isInputChk = true; // 인풋체크를 true로 바꿔줌으로써 가입하기 버튼 활성화 시키는 변수중 하나를 true로 바꾼다.

					}
					toggleJoinButton();// 가입하기 버튼 관련 함수를 실행한다.

				},
				error : function() {
					alert("읽기실패");
				}
			});
		});

		$("#m_pw,#m_name,#m_age"/* 다양한 요소를 한꺼번에 선택한다. */).keyup(toggleJoinButton);/*해당요소들에서 키보드를뗄떼 가입하기 버튼관련 함수가 실행된다.  */
		$("#m_age").on('change keyup', toggleJoinButton); /* 나이 인풋 창은 키보드 말고도 다름 방법으로도 값을 바꿀 수 있기 때문에 change 이벤트가 발생할때의 경우의 수를 추가하여 함수를 실행 시킨다.  */

		// 파라미터(하나일때 사용) => data : "m_id=" + $("#m_id").val()
		// 파라미터(여러개일때 사용) => 보통 직렬화(serialize()) => form 태그 안에서만 가능
		$("#btn_join").click(function() {
			let param = $("#myForm").serialize(); /* 폼에 있는 데이터를 제이쿼리를 이용해 선택하고 serialize를 이용한다. 그리고 쿼리 스트링을 리턴한다. */
			$.ajax({
				url : "/ajax_member_join",
				/* 		data : {
							m_id : $("#m_id").val(),
							m_pw : $("#m_pw").val(),
							m_name : $("#m_name").val(),
							m_age : $("#m_age").val(),
						}, */
				data : param,
				method : "post",
				dataType : "text",
				success : function(data) {
					if (data == '0') {
						alert("가입실패");
					} else {
						$("#tbody").empty();
						getList();
						//가입창 초기화
						$("#m_id").val("");
						$("#m_pw").val("");
						$("#m_name").val("");
						$("#m_age").val("");
						//$("#myForm")[0].reset();
						//주의) form은 배열로 넘어온다.
						$("span").text("중복여부");
						$("#btn_join").prop("disabled", true);
					}
				},
				error : function() {
				}
			});
		});

		//동적바인딩 변수 (click 안됨, on )
		// #list 부모 , #member_del 자식
		$("#list").on("click", "#member_del"/* 리스트 내에서도 특정 요소만을 선택 했을 때 함수가 실행된다. */, function() {
			//let m_id = $(this).attr("name");
			//alert(m_id);
			if (confirm("정말 삭제할까요?")) {
				$.ajax({
					url : "/ajax_member_delete",
					data : "m_idx=" + $(this).prop("name"), // 파라미터(하나일때 사용)
					method : "post",
					dataType : "text",
					success : function(data) {
						if (data == '0') {
							alert("삭제 실패");
						} else if (data == '1') {
							// 사용가능
							$("#tbody").empty();
							getList();
						}
					},
					error : function() {
						alert("읽기실패");
					}
				});
			} else {
				alert("삭제가 취소 되었습니다.");
			}
		});
		getList();
	</script>
</body>
</html>






<!-- classes 파일에 자바가 있다. 톰캣 폴더에 클래스 파일로 변경되어 있음 왜냐하면 그렇게 export 했으니까 시험에 나옴 -->










