<%@page import="member.MemberHistoryDTO"%>
<%@page import="member.MemberDetailDTO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.File"%>

<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="ddao" class="member.MemberDetailDAO"/>
<jsp:useBean id="hdao" class="member.MemberHistoryDAO"/>

<%
String idEmail = (String)session.getAttribute("sidEmail");
int index=dao.getMemberIndex(idEmail); //이메일을 통해 테이블 인덱스 얻기.
MemberDTO dto=dao.myProfileInfo(index); //그 멤버의 기본정보 가져오는 dao메소드.
MemberDetailDTO ddto=ddao.getMemberDetailInfo(index);
ArrayList<MemberHistoryDTO> arr = hdao.myProfileHistoryInfo(index); //그 멤버의 상세정보 가져오는 dao 메소드.
int cnt=arr.size(); //공모전 상세 내역을 기존에 존재하는 것 보다 큰 값으로 만들어야 속성값 겹치지 않음

%>

<%!
public String manageNull(String str) {
	if (str == null || str.equals("")) {
		return "";
	} else {
		return str;
	}
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
article{
	width:800px;
	margin-left: 100px;
}
.p_div{
	width: 100%;
	margin: 20px;
	padding: 10px;
	border-bottom:0.5px dotted gray;
}
.msgImg{
	width: 20px;
	padding-right: 5px;
}
.th1{
	width: 150px;
	font-size: 25px;
	text-align: left;
	padding: 10px;
}
.th2{
	width: 100px;
	font-size: 15px;
	text-align: left;
	padding: 10px;
	border-bottom: 0.5px gray dotted;
}
.td_line{
	width: 530px;
	padding: 10px;
	border-bottom: 0.5px gray dotted;
}
#toggle{
	width: 70px;
	height: 44px;
	border: none;
	margin: 10px;
}
</style>
<script>
//미리보기 이미지를 기본으로 세팅
function setDefaultImg(){
	myProfile.proimg.src = "/sp/img/profile_default.jpg";
}
//미리보기 이미지를 선택한 그림파일로 세팅
function showImg(profile){
	//파일 읽기
	var reader = new FileReader();
	var file = profile.files[0]; //파일배열로 저장되기때문에 첫번째 파일이 현재 선택된 파일.
	if(file === undefined){ // 파일 선택을 하지 않은 경우 = 선택 파일 없음
		setDefaultImg();
	}else{ //파일 선택한 경우
		reader.readAsDataURL(file); //파일 읽기
		//파일 로드 한 후
		reader.onload = function(){
			var img = myProfile.proimg; //미리보기 이미지를 띄울 객체(img태그)
			img.src = reader.result;
		};
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
//핸드폰 번호 입력시에 4자리의 번호만 입력할 수 있도록 하기. 
function checktel(tel){
    var num_pattern = /^\d{4}$/;  // 정규표현식 사용. []안에서 ^는 '일치하지 않는'을 의미한다.
    if(!num_pattern.exec(tel.value)) { //exec는 정규표현식 패턴에 맞는 문자열 탐색
        alert("해당 항목에는 4자리의 숫자만 사용할수 있습니다.\n다른 문자는 자동적으로 제거 됩니다.");
        tel.value = tel.value.replace(/.*/g,''); //숫자를 제외한 문자열 내 모든 패턴(g=global)찾아 빈문자열로 대체.
        return false;
    }
}
//카카오id 공백,특수문자 제거 함수
function checkKakaoId(obj) {
    var space_pattern = /[\s\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/;  // 정규표현식에서 공백문자 = \s 또는 = |
    if(space_pattern.exec(obj.value)) { //공백 체크, exec는 정규표현식 패턴에 맞는 문자열 탐색
        alert("해당 항목에는 공백 및 특수문자를 사용할수 없습니다.\n자동적으로 제거 됩니다.");
        obj.value = obj.value.replace(/[\s\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g,''); //제거
        return false;
    }
}
//지역 선택시에 추가 옵션 보여주는 함수.
function addOption(obj){
	var option = obj.value;
	var ary; 
	var addop = myProfile.sigungu;
	//추가 옵션이 이미 있던 경우 삭제해주기. 길이를 1로 두는 것은 '선택해주세요'만 남기고 삭제하기 위해서이다.
	if(addop.length>1){
		for(i=0; i<addop.length;i++){
			addop.length=1;
		}
	}
	//선택한 지역에 따라 추가 옵션을 다르게 함.
	if(option == '서울특별시'){
		ary = ['강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', 
			'동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', 
			'용산구', '은평구', '종로구', '중구', '중랑구 '];
		
		for(var i=0; i<ary.length;i++){
			var op = new Option();
			op.value = ary[i];
			op.text = ary[i];
			myProfile.sigungu.add(op);
		}
		myProfile.sigungu.hidden=false;
	}else{
		myProfile.sigungu.hidden=true;
	}
}
//공모전 기간 형식 지정 함수
function checkPeriod(obj) {
    var pattern = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;  // 숫자랑 -만 입력 가능, ^시작, $끝
    				//19나 20으로 시작하고 두개의 숫자가 옮. - 이후 0으로 시작하는 1~9월 또는 1로시작하는 10~12월.
   	if(!pattern.exec(obj.value)) { //공백 체크, exec는 정규표현식 패턴에 맞는 문자열 탐색
       	alert("\n정확한 년,월,일을 입력하세요.\n해당 항목에는 0000-00-00형식만 사용 할 수 있습니다.\n자동적으로 제거 됩니다.");
       	obj.value = obj.value.replace(/.*/,''); //제거
	}
}
//공모전 상세이력 추가.
var addCount = <%=cnt%>;
function pageAdd(){
	var tb = document.getElementById('tb');
	var row = tb.insertRow(tb.rows.length);
	var cell = row.insertCell(0);
	
	cell.innerHTML ='<tr>'
					+'<td>'	
						+'<table style="border:0.5px dotted black;width:800px;">'
						+'<tr>'
							+'<th class="th2">공모전 이름</th>'
							+'<td class="td_line">'
							+'<input type="text"style="width: 170px; height: 20px;" name="cNameUpdate" required="required">'
							+'</td>'
							+'<td rowspan="5">'
							+'<input type="button" value="-" onclick="pageDelPopup(this);" style="margin-left:20px"> 삭제하기' 
							+'</td>'
						+'</tr>'
						+'<tr>'
							+'<th class="th2">공모전 기간</th>'
							+'<td class="td_line"><input style="width: 170px; height: 20px;" type="text" id="periodUpdate_1" name="periodUpdate_1" onchange="checkPeriod(this);" required="required" placeholder=" ex) 2018-01-01">'
							+'&nbsp;~&nbsp;'
							+'<input style="width: 170px; height: 20px;" type="text" id="periodUpdate_2" name="periodUpdate_2" onchange="checkPeriod(this);" required="required" placeholder=" ex) 2018-06-30">'
							+'<input type="text" hidden="" id="periodUpdate" name="periodUpdate" value="">'
						+'</td>'
						+'</tr>'
						+'<tr>'
							+'<th class="th2">담당역할</th>'
							+'<td class="td_line">'
							+'<select id="part" onchange="select(this,\'inner\')" name="mainRoleUpdate">'
								+'<option selected>담당 역할</option>'
								+'<option value="developer">개발자</option>'
								+'<option value="desiner">디자이너</option>'
								+'<option value="planner">기획자</option>'
								+'<option value="etc">etc</option>'
							+'</select>'
							+'<div id="roleaddCount"></div>'
							+'<input style="width: 170px; height: 20px;" type="text" id="detailRoleaUpdate" name="detailRoleUpdate">'
							+'</td>'
						+'</tr>'
						+'<tr>'
							+'<th class="th2">수상내역</th>'
							+'<td class="td_line"><input style="width: 170px; height: 20px;" type="text" placeholder="ex)입선" name="awardUpdate">'
						+'</td>'
						+'</tr>'
						+'<tr>'
							+'<th style="width: 100px;font-size: 15px;text-align: left;padding: 10px;">상세내용</th>'
							+'<td style="width: 530px;padding: 10px;">'
							+'<textarea style="width:520px;height:100px;" placeholder="필요에 따라 입력해주세요.\n어떤 활약을 펼쳤는지 간단하게 작성해주시면 도움이 됩니다." name="detailUpdate"></textarea>'
						+'</td>'
						+'</tr>'
					+'</table>'
					+'</td>'
					+'</tr>'
	cell.style.borderTop="1px dotted green;"
	addCount++;
}
var length = <%=arr.size()%>; //갯수를 가져와서 넘겨받는 배열 크기를 지정해야함

//삭제 버튼 클릭시 부모 객체(table) remove
function pageDelPopup(row){
	
	var result = confirm('삭제되면 데이터 복구가 불가능합니다.\n그래도 삭제하시겠습니까?');
    if(result==true){
    	length--; //삭제 되면 db에있던 길이보다 1개 줄어듬
    	row.parentNode.parentNode.parentNode.parentNode.remove();
    	addCount--;
    }
}

//공모전 상세이력 안에 역할 선택.
function select(part,temp){
	var partname=part.value; //선택한 역할 값.
	var role;
	var inputRes;
	
	if(temp=='inner'){
		role = part.nextSibling; //현재 part 기준으로 다음 태그인 <div>태그 가리킴. 이 안에 세부역할 버튼들을 생성함.
		inputRes = role.nextSibling; // <div> 다음 태그인 <input> 태그 가리킴. 이 안에 세부역할 대입
	}else if(temp=='outer'){
		role = part.nextSibling.nextSibling; 
		inputRes = role.nextSibling.nextSibling;
	}
	
	//담당역할 선택 -> 세부사항 기입 불가, 세부사항 빈문자열.
	if(partname=="담당 역할"){
		inputRes.value = '';
		inputRes.readOnly=true;
	}else{
		inputRes.readOnly=false;
	}
	//div안에 있는 버튼 삭제
	while(role.firstChild) {
	  role.removeChild(role.firstChild);
	}
	//버튼에 사용할 value값들
	var ary; //value값들을 저장할 배열 변수 선언
	switch(partname){
	case "developer":
		ary = ['개발자','서버','DB','블록체인','클라우드','빅데이터','데이터 분석','IOS','안드로이드','WEB'];
		break;
	case "desiner":
		ary = ['UI/UX디자인','일러스트','에프터이펙트','포토샵','3D MAX','웹툰프로토타이핑 툴','BI디자인'];
		break;
	case "planner":
		ary = ['기획','마케팅','컨텐츠 제작','SNS','온라인 마케팅'];
		break;
	case "etc": //나중에 추가할 세부역할들.
		ary = ['영상 제작',	'영상 촬영','영상 편집','통계 분석','아이디어'];
		break;
	}
	//버튼 추가
	for(i=0; i<ary.length;i++){
		var bu =  document.createElement("input");
		bu.type = "button";
		bu.value = ary[i];
		bu.style.marginRight = "4px";
		bu.onclick = function(){inputRes.value = this.value;}; //기능 : 버튼 클릭시에 버튼 값이 자동으로 text에 입력
		role.appendChild(bu);
	}
}

var flag=true;
function toggleClick(){
	
	btn=document.getElementById('toggle');
	
	if(flag){
		btn.src='/sp/img/toggle_on.jpg';
		myProfile.toggleTyping.value='네. 프로필을 등록합니다.';
		myProfile.searchAgreement.value='true';
		flag=false;
	}else{
		btn.src='/sp/img/toggle_off.jpg';
		myProfile.toggleTyping.value='아니오. 프로필을 등록하지 않습니다.';
		myProfile.searchAgreement.value='false';
		flag=true;
	}
}

function checkLength(obj){
	var textvalue = new String(obj.value); // 자기소개의 입력된 문자열
	var tcount = 0; //자기소개의 입력된 값의 길이를 구할 변수

	for(i=0;i<textvalue.length;i++){
		var tchar = textvalue.charAt(i);
		var addlen = escape(tchar).length > 4? 3:1; //오라클 DB에서 한글은 3, 영어는 1이므로
		tcount += addlen;
		
		//varchar2(3000)으로 자기소개를 제한해두었기 때문에 아래와 같이 제한을 주기.
		if(tcount > 2990){
			alert('입력제한 길이를 초과하였습니다.');
			obj.value = textvalue.substr(0,i-1); //제한 길이를 넘길수 없게 textarea값 조정.
			tcount -=addlen; //조정한 길이 반영.
			break;
		}
	}
	
	myProfile.lengthinfo.value= tcount+'/2990bytes';
}

function isNull(){
	//사람 등록 하기 전, 추가 인적사항 작성 했는지 안했는지 확인하고
	if(myProfile.tel1.value=='' || myProfile.tel2.value=='' || myProfile.kakaoId.value=='' 
			|| myProfile.kakaoIdAgreement.value=='' || myProfile.birthYear.value=='' || 
			myProfile.sido.value=='' || myProfile.sigungu.value==''	|| 
			myProfile.mProfile.value==''){
		alert('"추가 인적사항"을 모두 작성하셔야 사람등록이 가능합니다.\n공모전 이력 제외');
	//작성 했으면 버튼 동작하도록 설계
	}else{
		toggleClick();
	}
}

function formCheck(){
	
	myProfile.addCount.value = addCount; // default = 여태 생성되어잇던 공모전 갯수  > 추가할 때 마다 증가함
	//전화번호 조합
	myProfile.contact.value = myProfile.headtel.value +"-"+ myProfile.tel1.value +"-"+ myProfile.tel2.value;
	
	//update 위해서 length값 알아야함
	myProfile.uIdxlength.value=length;
	
	//전화번호 입력 안했을 때, 빈문자열 저장.
	if(myProfile.contact.value == "010--")
		myProfile.contact.value = "";
	//생년월일 선택 안했을 때, 빈 문자열 저장.
	if(myProfile.birthYear.value == "선택해주세요"){
		myProfile.birthYear.value = "";
	}
	//시도 선택 안했을 때, 빈 문자열 저장.
	if(myProfile.sido.value == "선택해주세요"){
		myProfile.sido.value = "";
	}
	//시군구 선택 안했을 때, 빈 문자열 저장.
	if(myProfile.sigungu.value == "선택해주세요"){
		myProfile.sigungu.value = "";
	}
	
	//공모전 상세이력 기간 조합 - 기존에 존재하던 상세이력
	var size = document.getElementsByName('period').length;
	for(var i=0;i<size;i++){
		document.getElementsByName('period')[i].value = document.getElementsByName('period_1')[i].value+'~'+document.getElementsByName('period_2')[i].value
	}
	
	//새로 추가된 상세이력 기간 조합
	var size = document.getElementsByName('periodUpdate').length;
	for(var i=0;i<size;i++){
		document.getElementsByName('periodUpdate')[i].value = document.getElementsByName('periodUpdate_1')[i].value+'~'+document.getElementsByName('periodUpdate_2')[i].value
	}
	
	return true;
}

</script>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/mypage/aside.jsp" %>

<section>
<article>
	<form name="myProfile" action="myProfile_ok.jsp" method="post" onsubmit="return formCheck()" enctype="multipart/form-data">
	<!-- 최종 추가된 addCount 수 와 맨 처음 comp 갯수를 전송하여 공모전 상세이력 추가 , 삭제 및 수정 -->
	<input type="hidden" name="addCount" value="q">
	<input type="hidden" name="crtCompSize" value="<%=cnt%>">
	<div align="center" style="font-size:40px;font-weight:bold;margin:20px;">프로필 수정하기</div>
	<div class="p_div" align="center">
	<div align="left" style="margin-bottom:15px;font-size:30px;font-weight:bold;">기본 인적사항</div>
		<table border="1" style="width: 800px;">
			<tr>
			<%
			//카드에 출력될 프로필 가져오기.
			File userdir = new File(request.getServletContext().getRealPath("\\")+ "\\img\\profile\\"+index);
			File[] files = userdir.listFiles();
			String imagpath;
			if(files.length>0){
				imagpath = "/sp/img/profile/"+index+"/"+files[0].getName();
			}else{
				imagpath = "/sp/img/profile_default.jpg";
			}
			%>
				<td rowspan="3"><img name="proimg" style="margin-left:60px;width:120px;height:120px;" src="<%=imagpath %>"></td>
				<td style="font-size:35px;font-weight: bold;"><%=dto.getMName() %></td>
				<td style="font-size:15px;color:gray;"><%=manageNull(ddto.getBirthYear()).equals("")?"":manageNull(ddto.getBirthYear())+"년생" %></td>
				<td colspan="2" style="font-size:16px;"><%=dto.getFieldMajor() %></td>
			</tr>
			<tr>
				<td colspan="2"><img src="/sp/img/mail.png" class="msgImg"><%=dto.getidEmail() %></td>
				<td><img src="/sp/img/kakao.jpg" class="msgImg"><%=(ddto.getKakaoIdAgreement().equals("true"))?ddto.getKakaoId():"비공개" %></td>
				<td><img src="/sp/img/tell.jpg" class="msgImg"><%=(ddto.getContactAgreement().equals("true"))?ddto.getContact():"비공개" %></td>
			</tr>
			<tr>
				<td style="width:120px;">
					<input type="file" name="picture" onchange="showImg(this);" accept=""><br>
					<span style="margin-left:8px; font-size:8px; color:#FA5882;">파일 크기 제한은 5MB입니다.</span>
				</td>
				<td colspan="4"></td>
			</tr>
		</table>
		<div align="left">
			<table>
			<tr>
				<th class="th1">분야/전공</th>
				<td colspan="3">
					<input style="width:170px;height:20px;" type="text" name="fieldMajor" readonly="readonly" required="required" value="<%=manageNull(dto.getFieldMajor()) %>">
					<input type="button" value="찾기"  onclick="fieldMajorPop()">
				</td>
			</tr>
			<tr>
				<th class="th1">수신동의</th>
				<%String email=manageNull(dto.getEmailAgreement()); %>
				<td colspan="3">이메일 수신을 허가하시겠습니까?
					<input type="radio" name="emailAgreement" value="true" required="required" <%=(email.equals("true"))?"checked":""%>>예
					<input type="radio" name="emailAgreement" value="false" required="required" <%=(email.equals("false"))?"checked":""%>>아니오
				</td>
			</tr>
			</table>
		</div>
	</div>
	<div class="p_div">
	<div style="margin-botton:15px;font-size:30px;font-weight:bold;">추가 인적사항</div>
	<table style="width: 800px;margin-top:20px;">
	<tr>
		<th class="th1">핸드폰번호</th>
		<%
		String number = manageNull(ddto.getContact());
		String num1=null,num2=null,num3=null;
		if(number.equals("")){
			num1 = "010";
			num2 = "";
			num3 = "";
		}else{
		 num1 = number.substring(0,number.indexOf('-'));
		 num2 = number.substring(number.indexOf('-')+1,number.lastIndexOf('-'));
		 num3 = number.substring(number.lastIndexOf('-')+1);
		}
		
		String gca = manageNull(ddto.getContactAgreement());
		%>
		<td>
			<select name="headtel" style="height:30px;">
				<%
				String tel[]={"010","011","018"};
				for(int i=0;i<tel.length;i++){
					if(tel[i].equals(num1)){
						%><option value="<%=tel[i] %>" selected><%=tel[i] %></option><%
					}else{
						%><option value="<%=tel[i] %>"><%=tel[i] %></option><%
					}
				}
				%>
			</select> -
				<input style="width:70px;height:25px;" type="text" name="tel1" maxlength="4" onchange="checktel(this);" value="<%=num2%>"> -
				<input style="width:70px;height:25px;" type="text" name="tel2" maxlength="4" onchange="checktel(this);" value="<%=num3%>">
				<input style="text" hidden="" name="contact" value="">
			핸드폰 번호 공개 동의
			<input type="radio" id="r1" name="contactAgreement" value="true" <%=(gca.equals("true"))?"checked":""%>>
    		<label for="r1"><span></span>예</label>
    		<input type="radio" id="r2" name="contactAgreement" value="false" <%=(gca.equals("false"))?"checked":""%>>
    		<label for="r2"><span></span>아니오</label>
    	</td>	
	</tr>
	<tr>
		<th class="th1">카카오톡ID</th>
		<%
		String gkia = manageNull(ddto.getKakaoIdAgreement());
		%>
		<td>
		<input style="width:170px;height:25px;" type="text" name="kakaoId" placeholder="내용을 입력해주세요" onkeyup="checkKakaoId(this);" value="<%=manageNull(ddto.getKakaoId())%>">
		카카오톡ID 공개 동의
			<input type="radio" id="r3" name="kakaoIdAgreement" value="true" <%=(gkia.equals("true"))?"checked":""%>>
    		<label for="r3"><span></span>예</label>
    		<input type="radio" id="r4" name="kakaoIdAgreement" value="false" <%=(gkia.equals("false"))?"checked":""%>>
    		<label for="r4"><span></span>아니오</label>
    	</td>		
	</tr>
	<tr>
		<td style="font-size:10px;color:gray;"colspan="2">연락을 받고싶은 항목에 정보를 입력해주세요. 이메일 보다 빠르게 상대방과 연락을 주고 받을 수 있습니다.</td>
	</tr>
	<tr>
		<th class="th1">출생년도</th>
		<%
		String gb_year_s = manageNull(ddto.getBirthYear());
		int gbyear = 0;
		if(gb_year_s.equals("")){
			gbyear = 0;
		}else{
			gbyear = Integer.parseInt(gb_year_s); 
		}
		%>
		<td>
			<select name="birthYear" style="height:30px;">
				<option value="">선택해주세요</option>
				<%
				Calendar cal = Calendar.getInstance(); //서버시간기준으로 120세까지만 선택가능.
				int y = cal.get(Calendar.YEAR);
				for(int i=y;i>y-120;i--){
					if(i==gbyear){
					%>
					<option value="<%=i %>" selected><%=i %></option>
					<%
					}else{
					%>
					<option value="<%=i%>"><%=i%></option>
					<%
					}
				}
				%>
			</select>
		</td>
	</tr>
	<tr>
		<th class="th1">지역</th>
		<%
		String sd = manageNull(ddto.getSido());
		String sgg = manageNull(ddto.getSigungu());
		
		%>
		<td>
			<select onchange="addOption(this)" name="sido" style="height:30px;">
				<%
				String str[]={"선택해주세요","서울특별시","인천광역시","대구광역시","부산광역시","광주광역시","대전광역시","울산광역시","세종시","경기도","강원도","충청남도","충청북도","경상북도","경상남도","전라북도","전라남도","제주도"};
				for(int i=0;i<str.length;i++){
					if(sd.equals(str[i])){
						%>
						<option selected><%=str[i] %></option>
						<%
					}else{
						%>
						<option><%=str[i] %></option>
						<%
					}
				}
				%>
			</select>
			<select name="sigungu" style="height:30px;"> <!-- 추가옵션 달릴 부분 -->
				<option>선택해주세요</option>
			</select>
			<script>
			addOption(myProfile.sido);
			
			for(var i=0	;i<document.myProfile.sigungu.length;i++){
				if(document.myProfile.sigungu.options[i].value=="<%=sgg%>"){
					document.myProfile.sigungu.options[i].selected=true;
				}
			}
			</script>
		</td>
	</tr>
	<tr>
		<th class="th1">공모전 이력&nbsp;</th>
		<td>
			<input type="button" value="+" onclick="pageAdd();"> 추가하기
		</td>
	</tr>
	</table>
	<input type="hidden" name="uIdxlength" value="">
	<table>
		<tbody id="tb">
		<%
		
		for(int i=0;i<arr.size();i++){
			
			int idx=arr.get(i).getMemberHistroyIx();
		%>
		
			<tr>
			<td>
				<table style="border:0.5px dotted black;width:800px;">
					<tr>
						<th class="th2">공모전 이름</th>
						<td class="td_line">
						
						<input type="text"style="width: 170px; height: 20px;" name="cName" required="required" value="<%=arr.get(i).getCName() %>">
						</td>
						<td rowspan="5">
							<input type="button" value="-" onclick="pageDelPopup(this);" style="margin-left:20px"> 삭제하기
							<!-- update되는 idx만 넘어가는 value -->
							<input type="hidden" name="updateIdx" value="<%=idx%>">
						</td>
					</tr>
					<tr>
						<th class="th2">공모전 기간</th>
						<%
						String period=arr.get(i).getPeriod();
						String p1=period.substring(0,period.indexOf('~'));
						String p2=period.substring(period.lastIndexOf('~')+1);
						%>
						<td class="td_line"><input style="width: 170px; height: 20px;" type="text" id="period<%=i %>_1" name="period_1" onchange="checkPeriod(this);" required="required" placeholder=" ex) 2018-01-01" value="<%=p1%>">
						&nbsp;~&nbsp;
						<input style="width: 170px; height: 20px;" type="text" id="period<%=i %>_2" name="period_2" onchange="checkPeriod(this);" required="required" placeholder=" ex) 2018-06-30" value="<%=p2%>">
						<input type="text" hidden="" id="period<%=i %>" name="period" value="">
					</td>
					</tr>
					<tr>
						<th class="th2">담당역할</th>
						<% String role=arr.get(i).getDetailRole(); %>
						<td class="td_line">
						<select id="part" onchange="select(this,'outer')" name="mainRole">
							<option selected>담당 역할</option>
							<option value="developer">개발자</option>
							<option value="desiner">디자이너</option>
							<option value="planner">기획자</option>
							<option value="etc">etc</option>
						</select>
						<div id="role<%=i %>"></div>
						<input style="width: 170px; height: 20px;" type="text" id="detailRole<%=i %>" name="detailRole" value="<%=role %>">
						</td>
					</tr>
					<tr>
						<th class="th2">수상내역</th>
						<td class="td_line"><input style="width: 170px; height: 20px;" type="text" placeholder="ex)입선" name="award" value="<%=arr.get(i).getAward()%>">
					</td>
					</tr>
					<tr>
						<th style="width: 100px;font-size: 15px;text-align: left;padding: 10px;">상세내용</th>
						<td style="width: 530px;padding: 10px;">
						<textarea style="width:520px;height:100px;" placeholder="필요에 따라 입력해주세요.\n어떤 활약을 펼쳤는지 간단하게 작성해주시면 도움이 됩니다." name="detail"><%=arr.get(i).getDetail() %></textarea>
					</td>
					</tr>
				</table>
				</td>
				</tr>
		<%} %>
		</tbody>
	</table>
	<table>
	<tr>
		<th class="th1">자기소개</th>
		<td>
			<textarea name="mProfile" onkeyup="checkLength(this);" placeholder="자신이 현재 관심있는 분야 /프로젝트를 작성해주세요." style="width:500px;height:200px;"><%=manageNull(ddto.getmProfile()) %></textarea>
			<input type="text" readonly="readonly" name="lengthinfo" style="border: none;" value="">
		</td>	
	</tr>
	</table>
	<br>
	<div>
	<div align="center" style="font-size:30px;">현재 프로필을 <b>사람검색</b>에 등록하시겠습니까?</div>
	<div style="margin-left:250px;">
		<table>
		<tr>
		<%
		String ga = manageNull(ddto.getSearchAgreement());
		%>
			<td>
			<img id="toggle" onclick="isNull();" src="<%=ga.equals("true")?"/sp/img/toggle_on.jpg":"/sp/img/toggle_off.jpg" %>">
			<input type="hidden" id="searchAgreement" name="searchAgreement" value="false">
			</td>
			<td>
			<input type="text" id="toggleTyping" disabled="disabled" style="background: none;border:none; width:300px;color: black;" value="<%=(ga.equals("true"))?"네. 프로필을 등록합니다.":"아니오. 프로필을 등록하지 않습니다." %>">
			</td>
		</tr>
		</table>
	</div>
	</div>
	<div align="center"><input type="submit" value="정보 수정하기" style="width:150px;height:50px;"></div>
	</div>
	</form>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>