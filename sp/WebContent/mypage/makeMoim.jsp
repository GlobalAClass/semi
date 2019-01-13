<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
article{
	width:900px;
	margin:20px;"
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/mypage/aside.jsp" %>
<section>
<article>
	<div align="center">
	<h2>마이페이지 - 내가 만든 모임</h2>	
	<%@include file="/mypage/makeMoimCard.jsp" %>
	</div>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>