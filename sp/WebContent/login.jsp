<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 하기</title>
<link rel="stylesheet" type="text/css" href="css/mainLayout.css">
<style>
h1{
	text-align: center;
	font-size: 30px;
}
table{
	margin: 0px auto;
	text-align: center;
}
#login{
	background: #424242;
	font-size: 20px;
	font-weight: bold;
	color: white;
	width:100px;
	height:120px;
}
.t1{
	width:240px;
	height:40px;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
	<article>
		<form name="login.jsp" action="login_ok.jsp">
		<h1>로그인</h1>
		<table>
		<tr>
			<td><input type="text" name="id" placeholder=" 아이디" required="required" class="t1"></td>
			<td rowspan="2"><input id="login" type="submit" value="로그인"></td>
		</tr>
		<tr>
			<td><input type="password" name="pwd" placeholder=" 비밀번호" required="required" class="t1"></td>
		</tr>
		<tr>
			<td colspan="2" style="font-size:12px;color:gray;">홈페이지 방문이 처음이신가요?</td>
		</tr>
		<tr>
			<td colspan="2"><a href="/sp/memberJoin.jsp" style="font-size:20px;color:black;">회원가입</a></td>
		</tr>
		</table>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>