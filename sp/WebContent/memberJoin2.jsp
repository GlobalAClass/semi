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
#memberinput{
	border-top: 1px solid black;
	background: #BDBDBD;
	color: white;
	font-size: 18px;
	font-weight: bold;
	padding: 5px;
}
</style>
</head>
<body>
<%@include file="/header.jsp"%>
<section>
	<article>
		<form name="memberJoin" action="memberJoin_ok.jsp">
		<h1>회원가입</h1>
		<div id="memberinput">회원정보 입력</div>
		<fieldset>
		<legend>추가입력정보</legend>
			<table>
				<tr>
					
				</tr>
			</table>
		</fieldset>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>