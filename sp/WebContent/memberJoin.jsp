<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/mainLayout.css">
<script>
function select(){
	var email=document.memberJoin.id.value;
	document.memberJoin.email2.value=email;
}
</script>
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
#addinfo{
	background: black;
	color: white;
	font-size: 16px;
	font-weight: bold;
}
article table{
	width: 100%;
	height: 400px;
}
#design{
	border-bottom: 1px dotted black;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
	<article>
		<form name="memberJoin" action="memberJoin_ok.jsp">
		<h1>회원가입</h1>
		<div id="memberinput">회원정보 입력</div>
		<fieldset>
		<legend>필수입력정보</legend>
			<table>
				<tr>
					<th id="design">이메일</th>
					<td id="design">
						<input style="width:170px;height:20px;" type="text" placeholder="내용을 입력해주세요" required="required" name="email">@
						<input style="width:170px;height:20px;" type="text" name="email2">
					</td>
					<td id="design">
						<select name="id" onchange="select()">
							<option value="">선택하세요</option>
							<option value="naver.com">naver.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
							<option value="daum.net">daum.net</option>
							<option value="hotmail.com">hotmail.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="">직접입력</option>
						</select>
					</td>
					<td id="design"><input type="button" value="중복확인"></td>
				</tr>
				<tr>
					<th id="design">비밀번호</th>
					<td id="design" colspan="3"><input style="width:170px;height:20px;" placeholder="내용을 입력해주세요" required="required" type="password" name="pwd"></td>
				</tr>
				<tr>
					<th id="design">비밀번호확인</th>
					<td id="design" colspan="3"><input style="width:170px;height:20px;" placeholder="내용을 입력해주세요" required="required" name="pwd2"></td>
				</tr>
				<tr>
					<th id="design">이름</th>
					<td id="design" colspan="3"><input style="width:170px;height:20px;"	placeholder="내용을 입력해주세요" required="required" type="text" name="name"></td>
				</tr>
				<tr>
					<th id="design">분야/전공</th>
					<td colspan="3" id="design">
						<input style="width:170px;height:20px;" type="text" name="major">
						<input type="button" value="찾기">
					</td>
				</tr>
				<tr>
					<th id="design">수신동의</th>
					<td id="design" colspan="3">이메일 수신을 허가하시겠습니까?
						<input type="radio" name="yes">예
						<input type="radio" name="yes">아니오
					</td>
				</tr>
				<tr>
					<th>추가정보입력</th>
					<td>&nbsp;&nbsp;<a href="/sp/memberJoin2.jsp"><input id="addinfo" type="button" value="+"></a></td>
				</tr>
			</table>
			</fieldset>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>