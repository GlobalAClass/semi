<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="db.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="member.MemberDTO" %>
<%@ page import="member.MemberDAO" %>

<jsp:useBean id="mdao" class="member.MemberDAO" scope="session"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
h1{
	text-align: center;
	font-size: 30px;
	margin-top: 4px;
}
#memberinput{
	border-top: 1px solid gray;
	border-bottom: 1px solid gray;
	color:gray;
	font-size: 18px;
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
.th_style{
	font-size:20px;
	font-weight: bold;
	border-bottom: 1px dotted black;
}
</style>
<script>
//이메일 선택에 따라 자동 완성.
function select(){
	var email=document.memberJoin.selectEmail.value;
	
	if(email != "직접입력"){
		document.memberJoin.idEmail2.value=email;
		document.memberJoin.idEmail2.readOnly="readonly";
	}
	else{
		document.memberJoin.idEmail2.readOnly=false;
		document.memberJoin.idEmail2.value="";
	}
}
//공백 제거 함수
function noSpaceThisForm(obj) {
    var space_pattern = /\s/;  // 정규표현식에서 공백문자 = \s
    if(space_pattern.exec(obj.value)) { //공백 체크, exec는 정규표현식 패턴에 맞는 문자열 탐색
        alert("해당 항목에는 공백을 사용할수 없습니다.\n공백은 자동적으로 제거 됩니다.");
        obj.value = obj.value.replace(/\s/g,''); // 공백제거, 공백을 문자열 내 모든 패턴(g=global)찾아 대체
        return false;
    }
 	// onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);" 태그에 이걸 두고 활용.
}
//비밀번호와 비밀번호 확인이 같은지 출력.
function checkPwd(){
	pwd1 = document.memberJoin.pwd1.value;
	pwd2 = document.memberJoin.pwd2.value;
	
	if(typeof pwd2 != "undefined" && pwd2.length>0){
		if(pwd1 == pwd2){
			document.memberJoin.checkpwd.value = "비밀번호가 일치합니다.";
			document.memberJoin.checkpwd.style.color = 'green';
			document.memberJoin.pwd.value=pwd2; //일치한 비밀번호 저장.
		}else{
			document.memberJoin.checkpwd.value = "비밀번호가 일치하지 않습니다.";
			document.memberJoin.checkpwd.style.color = 'red';
		}
	} else{
		document.memberJoin.checkpwd.value = "비밀번호확인을 입력하세요.";
		document.memberJoin.checkpwd.style.color = 'red';
	}
}
//올바른 이메일 주소인지 확인. = ^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$ 
function checkCorrectEmail(str) {
    var email_pattern = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if(!email_pattern.exec(str)) { //exec는 정규표현식 패턴에 맞는 문자열 탐색
        return false;
    }else{
    	return true;
    }
}
//아이디(=이메일) 중복 확인 
function checkEmailPop(){
	idEmail=document.memberJoin.idEmail1.value;
	idEmail2=document.memberJoin.idEmail2.value;
	
	if(typeof(idEmail)!="undefined" && idEmail!="" && typeof(idEmail2)!="undefined" && idEmail2!=""){
		var email_str = idEmail+'@'+idEmail2; //올바른 이메일 주소인지 확인하기 위한 문자열 변수.
		if(checkCorrectEmail(email_str)){ //checkCorrectEmail(str)은 올바른 이메일 주소면 true 아니면 false 반환. 해당 함수는 바로 위에 선언되어있음.
			var go_ref = '/sp/memberJoin/memberJoin.jsp?'+'&idEmail1='+idEmail+'&idEmail2='+idEmail2;
			location.href = go_ref;	
		}else{
	        alert("올바른 이메일 주소를 입력하세요");
		}
	}else{
		alert("이메일주소를 입력하세요.");
	}
}
//분야,전공 찾기 팝업 - 윈도우 창 기준으로 팝업 중앙에 뜨게 함.
function fieldMajorPop(){
	var popwidth = 500; //팝업창 가로 길이 설정
	var popheight = 500; //팝업창 가로 길이 설정
	//윈도우창의 크기 절반, 팝업창의 크기 절반 수치
	var popupX = (window.screen.availWidth-popwidth)/2; 
	var popupY = (window.screen.availHeight-popheight)/2; 
	window.open('fieldMajorPop.jsp', 'fieldMajorPop', 'width='+popwidth+', height='+popheight
				+',left='+popupX + ', top='+ popupY );
}
//submit 전에 유효성 검사
function formCheck(){
	if(memberJoin.idEmail.value == ""){
		alert("아이디 중복을 확인해주세요.");
		memberJoin.cid.focus();
		return false;
	}else if(memberJoin.pwd.value == ""){
		alert("비밀번호를 확인해주세요.");
		memberJoin.pwd.focus();
		return false;
	}else if(memberJoin.MName.value == ""){
		alert("이름을 입력해주세요.");
		memberJoin.MName.focus();
		return false;
	}else if(memberJoin.fieldMajor.value == ""){
		alert("분야/전공을 입력해주세요.");
		memberJoin.fieldMajor.focus();
		return false;
	}else if(memberJoin.emailAgreement.checked == true){
		alert("수신동의를 입력해주세요.");
		memberJoin.emailAgreement.focus();
		return false;
	}else{
		return true;
	}
}
</script>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
	<article>
		<form name="memberJoin" action="memberJoinAdd.jsp" method="post" onsubmit="return formCheck()">
		<h1>회원가입</h1>
		<div id="memberinput"><span style="color:black;font-weight: bold;">1. 필수 입력정보</span> > 2. 추가 입력정보 > 3. 회원가입 완료</div>
			<table>
				<tr>
					<th class="th_style">이메일</th>
					<td id="design">
						<input type="text" hidden="" name="idEmail" value=""><!-- 중복 확인된 아이디값 넣을 태그 -->
						<%
							String idEmail1 = request.getParameter("idEmail1");
							String idEmail2 = request.getParameter("idEmail2");
							
							if(idEmail1!=null && !idEmail1.equals("") && idEmail2!=null && !idEmail2.equals("")){
								//각각의 텍스트 값 합쳐서 이메일 주소 만들기.
								String idEmail =  idEmail1+"@"+idEmail2;
								//이메일 중복 확인
								if(mdao.checkEmail(idEmail)){
									%>
									<script>
										alert('아이디 중복입니다. \n다른 아이디를 입력하세요.');
									</script>
									<%
								}else{
									%>
									<script>
										alert('<%=idEmail%> \n사용 가능한 아이디입니다.');
										memberJoin.idEmail.value = '<%=idEmail%>';
										//alert(memberJoin.idEmail.value);
									</script>
									<%
								}
							}
						%>
						<input style="width:150px;height:25px;" type="text" placeholder=" 아이디 입력" 
								required="required" name="idEmail1"  onchange="noSpaceThisForm(this);"
								value=<%if(idEmail1==null){ out.print("");}else{out.print(idEmail1);}%>> @
						<input style="width:150px;height:25px;" type="text" name="idEmail2" required="required" onchange="noSpaceThisForm(this);"
								value=<%if(idEmail2==null){ out.print("");}else{out.print(idEmail2);} %>>
						<select name="selectEmail" onchange="select()" style="width:150px;height:30px;">
							<option value="">선택하세요</option>
							<option value="naver.com">naver.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
							<option value="daum.net">daum.net</option>
							<option value="hotmail.com">hotmail.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="직접입력">직접입력</option>
						</select>
						<input type="button" name="cid" value="중복확인" style="width:80px;height:30px;margin-left: 20px;" onclick="checkEmailPop()">
					</td>
				</tr>
				<tr>
					<th class="th_style">비밀번호</th>
					<td id="design" colspan="3">
						<input type="text" hidden="" name="pwd" value="">
						<input style="width:250px;height:30px;" placeholder="비밀번호 입력" required="required" 
								type="password" name="pwd1" onchange="noSpaceThisForm(this);checkPwd()">
					</td>
				</tr>
				<tr>
					<th class="th_style">비밀번호 확인</th>
					<td id="design" colspan="3">
						<input style="width:250px;height:30px;" placeholder="비밀번호 재입력" required="required" 
								type="password" name="pwd2" onchange="noSpaceThisForm(this);checkPwd()">
						<input type="text" name=checkpwd disabled="disabled" style="width: 200px; border: none; background: none;">
					</td>
				</tr>
				<tr>
					<th class="th_style">이름</th>
					<td id="design" colspan="3">
						<input style="width:150px;height:30px;"	maxlength="15" placeholder="실명을 입력해주세요" required="required" 
								type="text" name="MName" onchange="noSpaceThisForm(this);">
					</td>
				</tr>
				<tr>
					<th class="th_style">분야/전공</th>
					<td colspan="3" id="design">
						<input style="width:150px;height:30px;" type="text" name="fieldMajor" readonly="readonly" required="required">
						<input type="button" value="찾기"  onclick="fieldMajorPop()" style="width:70px;height:35px;">
					</td>
				</tr>
				<tr>
					<th class="th_style">수신동의</th>
					<td id="design" colspan="3">이메일 수신을 허가하시겠습니까?
						<input type="radio" name="emailAgreement" value="true" required="required">예
						<input type="radio" name="emailAgreement" value="false" required="required">아니오
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="다음으로" style="width:100px;height:35px;">
						<input type="button" value="가입 취소" onclick="javascript:location.href='/sp/index.jsp';" style="width:110px;height:35px;">
						<!--  <a href="/sp/memberJoin2.jsp"><input id="addinfo" type="button" value="+"></a> -->
					</td>
				</tr>
			</table>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>