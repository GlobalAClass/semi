<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/mypage/aside.jsp" %>
<section>
<article>
<h2>마이페이지 - 내가 만든 모임 - 지원글 상세</h2>
<table border="1">
	<tr>
		<td rowspan="3"><img src="/sp/img/profile.jpg" style="width:80px;height:80px;padding:2px;"></td>
		<td style="font-weight: bold; font-size:30px">김영희</td>
		<td style="width:80px;font-size:15px; color:gray;">1997년생</td>
		<td colspan="2" align="right">컴퓨터공학전공</td>
	</tr>
	<tr>
		<td colspan="3"><img src="/sp/img/location.png" style="width:20px;height:20px;padding-right:5px;">경기도 수원시</td>
		<td align="right" rowspan="2"><img src="/sp/img/heart.jpg" style="width:30px;height:30px;padding:5px;"></td>
	</tr>
	<tr>
		<td colspan="3"><img src="/sp/img/mail.png"  style="width:20px;height:15px;padding-right:5px;">yhkim@gmail.com</td>
	</tr>
</table>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>