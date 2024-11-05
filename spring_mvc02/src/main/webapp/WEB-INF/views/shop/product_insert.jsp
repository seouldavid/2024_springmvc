<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table{
border: 1px solid black;
/* border-collapse: collapse; */
}
fieldset{
width:500px;
}
td{
border: 1px solid black;
}

</style>
</head>
<body>
	<fieldset>
		<legend>상품등록</legend>
		<form action="/shop_product_insert_ok" method="post" enctype="multipart/form-data">
			<table>
			<tbody>
					<tr>
						<th>분류</th>
						<td><input type="radio" name="category" value="com001">컴퓨터
							<input type="radio" name="category" value="ele002">가전
							제품 <input type="radio" name="category" value="sp003">스포츠
						</td>
					</tr>
				
				
					<tr>
						<td>제품번호</td>
						<td><input type="text" name="p_num"></td>
					</tr>
					<tr>
						<td>제품명</td>
						<td><input type="text" name="p_name"></td>
					</tr>
					<tr>
						<td>판매사</td>
						<td><input type="text" name="p_company"></td>
					</tr>
					<tr>
						<td>상품가격</td>
						<td><input type="text" name="p_price"></td>
					</tr>
					<tr>
						<td>할인가</td>
						<td><input type="text" name="p_saleprice"></td>
					</tr>
					<tr>
						<td>상품이미지s</td>
						<td><input type="file" id="file" name="file_s" required></td>
					</tr>
					<tr>
						<td>상품이미지L</td>
						<td><input type="file" id="file" name="file_l" required></td>
					</tr>
					<tr>
						<td>상품내용</td>
						<td></td>
					</tr>
					<tr>
					<td colspan="2">
						<textarea rows="10" cols="40" name="p_content"></textarea>
					</td>	
					</tr>
					<tr>
					<td colspan="2">
					<input type="submit" value="상품등록">
					</td>
						
					</tr>
				</tbody>
			</table>
		</form>
	</fieldset>
</body>
</html>