<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사람 검색</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
</style>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<select style="font-size:15px;margin-bottom:10px;">
				<option selected>지역</option>
				<option value="서울특별시">서울특별시</option>
				<option value="인천광역시">인천광역시</option>
				<option value="대구광역시">대구광역시</option>
				<option value="부산광역시">부산광역시</option>
				<option value="광주광역시">광주광역시</option>
				<option value="대전광역시">대전광역시</option>
				<option value="울산광역시">울산광역시</option>
				<option value="세종시">세종시</option>
				<option value="경기도">경기도</option>
				<option value="강원도">강원도</option>
				<option value="충청남도">충청남도</option>
				<option value="충청북도">충청북도</option>
				<option value="경상북도">경상북도</option>
				<option value="경상남도">경상남도</option>
				<option value="전라북도">전라북도</option>
				<option value="전라남도">전라남도</option>
				<option value="제주도">제주도</option>
			</select>
			<input type="text" placeholder="분야/전공 검색" readonly="readonly" style="height:18px;">&nbsp;<input type="button" value="찾기">
		</article>
	</section>
	<section>
	<article style="margin:20px;">
	<%@include file="humanCard.jsp" %>
	</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>