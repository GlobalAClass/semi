<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.net.*" %>
    
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
input[type="checkbox"] {
    display:none;
}

input[type="checkbox"] + label {
    color:black;
    margin-left: 5px;
}

input[type="checkbox"] + label span {
    display:inline-block;
    width:19px;
    height:19px;
    margin:-2px 10px 0 0;
    vertical-align:middle;
    background:url(/sp/img/check_radio_sheet.png)  0px -1px no-repeat;
    cursor:pointer;
}

input[type="checkbox"]:checked + label span {
    background:url(/sp/img/check_radio_sheet.png) -19px -1px no-repeat;
}
</style>
</head>
<%
Cookie[] cks = request.getCookies();
String idEmail=null;
for(int i =0; i<cks.length; i++){
        if(cks[i].getName().equals("saveidEmail")){
                idEmail = URLDecoder.decode(cks[i].getValue());
        }
}
%>
<body>
<%@include file="/header.jsp" %>
<section>
	<article>
		<form name="login.jsp" action="login_ok.jsp">
		<h1>로그인</h1>
		<table>
		<tr>
			<%if(idEmail==null){ %>
			<td><input type="text" name="idEmail" placeholder="이메일아이디" required="required" class="t1"></td>
			<%} else{ %>
			<td><input type="text" name="idEmail" value="<%=idEmail %>" required="required" class="t1"></td>
			<%}%>
			<td rowspan="2"><input id="login" type="submit" value="로그인"></td>
		</tr>
		<tr>
			<td><input type="password" name="pwd" placeholder=" 비밀번호" required="required" class="t1"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="checkbox" id="check" name="rememberidEmail" value="on" <%=idEmail==null||idEmail.equals("")? "":"checked" %>/>
    					<label for="check"><span></span>ID 기억하기</label></td>
		</tr>
		<tr>
			<td colspan="2" style="font-size:12px;color:gray;">홈페이지 방문이 처음이신가요?</td>
		</tr>
		<tr>
			<td colspan="2"><a href="/sp/memberJoin/memberJoin.jsp" style="font-size:20px;color:black;">회원가입</a></td>
		</tr>
		</table>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>