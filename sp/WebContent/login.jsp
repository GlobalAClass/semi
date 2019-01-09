<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/mainLayout.css">
<style>
h1{
	text-align: center;
	font-size: 30px;
	margin-top: 4px; 
}
article{
	text-align: center;
}
#login{
	background: #424242;
	font-size: 20px;
	font-weight: bold;
	color: white;
}	
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
	<article>
		<form name="login.jsp" action="login_ok.jsp">
		<h1>로그인</h1>
		<input style="width:240px;height:26px;" type="text" name="id" placeholder="아이디" required="required"><br><br>
		<input style="width:240px;height:26px;" type="password" name="pwd" placeholder="비밀번호" required="required"><br><br>
		<input id="login" style="width:250px;height:34px;" type="submit" value="로그인">
		<div>회원가입&nbsp;&nbsp;|&nbsp;&nbsp;ID/PW찾기</div>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>