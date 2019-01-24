<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="member.*" %>

<jsp:useBean id="memberdao" class="member.MemberDAO"/>
<jsp:useBean id="mddao" class="member.MemberDetailDAO"/>
<jsp:useBean id="mhdao" class="member.MemberHistoryDAO"/>

<%!
	//
	public String manageNull(String str) {
		if (str == null || str.equals("")) {
			return "";
		} else {
			return str;
		}
	}
%>

<%
	//로그인해야 해당 페이지를 이용할 수 있음.
	String uname = (String)session.getAttribute("smname");
	String uid = (String)session.getAttribute("sidEmail");
	
	if(uname == null || uname.equals("") || uid==null || uid.equals("")){
		%>
		<script>
			alert("로그인하셔야 이용하실 수 있습니다.");
			location.href="/sp/login.jsp";
		</script>
		<%
		return ;
	}
	
	//사용할 인덱스 구하기
	int member_ix = memberdao.getMemberIndex(uid);
	int com_ix = Integer.parseInt(request.getParameter("ix"));
	
	//글쓴이 내용 출력을 위한 DTO구하기
	MemberDTO memberdto = memberdao.getMemberInfo(member_ix);
	MemberDetailDTO mddto = mddao.getMemberDetailInfo(member_ix);
	
	//이미지경로 구하기.
	File userdir = new File(request.getServletContext().getRealPath("\\")+ "\\img\\profile\\"+member_ix);
	File[] files = userdir.listFiles();
	String imagpath;
	if(files.length>0){
		imagpath = "/sp/img/profile/"+member_ix+"/"+files[0].getName();
	}else{
		imagpath = "/sp/img/profile_default.jpg";
	}
	//null값인지 체크하기.
	String birthyear = manageNull(mddto.getBirthYear());
	
	//회원인덱스로 회원의 공모전 이력 받기
	ArrayList<MemberHistoryDTO> list = mhdao.getMemberHistoryInfo(member_ix);
	int len = 0;
	if(list!=null){
		len = list.size();
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
	margin-left:200px;
}
.sub{
	font-weight: bold;
}
#compInfo{
	width:800px;
	border-bottom: 0.5px dotted black;
	padding: 20px;
}
.bodytype{
	width: 800px;
	border-bottom: 0.5px dotted black;
	padding: 20px;
}
.bodytype2{
	width: 800px;
	padding-top: 20px;
	padding-left: 20px;
	padding-right: 20px;
}
.btn{
	width: 150px;
	height: 50px;
	font-size: 20px;
	margin: 20px;
}
#pfimg{
	width:80px;
	height:80px;
	padding:2px;
}
</style>
<script type="text/javascript">
//지역 선택시에 추가 옵션 보여주는 함수.
function addOption(obj){
	var option = obj.value;
	var ary;
	var addop = CompetitionMoimMake.sigungu;
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
			CompetitionMoimMake.sigungu.add(op);
		}
		CompetitionMoimMake.sigungu.hidden=false;
	}else{
		CompetitionMoimMake.sigungu.hidden=true;
	}
}

function select(part,temp){
	   var partname=part.value; //선택한 역할 값.
	   var inputRes;
	   var role;
	   
	   if(temp=='inner'){ //innerText에 존재하는 담당 역할
	      inputRes=part.nextSibling;
	      role=inputRes.nextSibling.nextSibling; 
	   }else if(temp=='outer'){ //외부 html에 존재하는 담당 역할
	      inputRes=part.nextSibling.nextSibling;
	      role=inputRes.nextSibling.nextSibling; 
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
	      ary = ['영상 제작',   '영상 촬영','영상 편집','통계 분석','아이디어'];
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
var cnt=0;
var people = new Array(); //각 담당 역할의 인원수가 선택될 때 저장할 배열
//현재 팀이 존재하는지 확인 하여 세부사항 작성칸 출력 여부
function nowTeam(res){
	switch(res){
	case "yes":
		document.all.nowTeamMember.style.display="";
		break;
	case "no":
		document.all.nowTeamMember.style.display="none";
		var tb = document.getElementById('tb');
		var len = tb.rows.length;
		for(var i =0; i<len; i++){
			tb.deleteRow(0);
		}
		people = new Array();
		cnt = 0;
		break;
	}
}
function addTeam(){

	var tb = document.getElementById('tb');
	var row = tb.insertRow(cnt);
	
	row.innerHTML='<div>'
					+'<table>'
						+'<tr>'
						+'<td>'
						+'<img src="/sp/img/profile_default.jpg" style="width:50px;height:50px margin-top:10px;">'
						+'</td>'
						+'<td style="width:420px;border-bottom:0.5px gray dotted;">'
						+'<select name="ogMainRole" onchange="select(this, \'inner\')" style="width:130px;height:25px;">'
							+'<option selected>선택하기</option>'
							+'<option value="developer">개발자</option>'
							+'<option value="desiner">디자이너</option>'
							+'<option value="planner">기획자</option>'
							+'<option value="etc">etc</option>'
						+'</select>'
						+'<input style="width:170px;height:20px;margin-left:10px;" type="text" name="ogDetailRole" required="required" required="required">'
						+'<div style="font-size:11px; color:#D20505;">해당 담당 역할이 없는경우 직접 작성해주세요. (1개 선택 가능)</div>'
						+'<div id="btnDivnowTeam" style="width:300px"></div>'
						+'</td>'
						+'<td style="border-bottom:0.5px gray dotted;">'
							+' 인원 수 '
							+'<select name="memberNumber" onchange="cntTeam(this)">'
								+'<option value="0" selected>선택하세요</option>'
								+'<option value="1" >1명</option>'
								+'<option value="2">2명</option>'
								+'<option value="3">3명</option>'
								+'<option value="4">4명</option>'
							+'</select>'	
							+'</td>'
							+'<td style="border-bottom:0.5px gray dotted;">'
							+'<input type="button" value="-" onclick="delTeam(this);" style="margin-left:20px"> 팀원 삭제하기'									
							+'</td>'										
						+'</td>'
						+'</tr>'
					+'</table>'
				+'</div>'
	people.push(0); //테이블 생성하면 인원수 계산하는 배열에 인원수 1 넣어주기
	cnt++;
}

function delTeam(row){ //팀원 삭제하는 함수

	var idx = row.parentNode.parentNode.rowIndex; //삭제 눌린 해당 인덱스 찾기
	var tb = document.getElementById('tb');
	tb.deleteRow(idx); //인덱스에 해당하는 줄 지우기
	people.splice(idx,1); //테이블 삭제되면 해당 인덱스에 해당하는 인원수 넣은 배열 삭제
	cnt--;
	
	var sum=0;
	for(var i=0;i<cnt;i++){
		sum += Number(people[i]);
	}
	document.all.sumTeam.value=sum;
	
}

function cntTeam(count){ //셀렉트 박스 변경될 때 마다 인원수 측정하여 변경해주는 함수
	var sum=0;
	var idx = count.parentNode.parentNode.rowIndex; //select box가 선택된 해당 인덱스
	for(var i=0;i<cnt;i++){
		if(i==idx){
			people[i]=count.value;
		}
	}
	for(var i=0;i<cnt;i++){
		sum += Number(people[i]);
	}
	document.all.sumTeam.value=sum;
}
var wcnt=0;
var wpeople = new Array(); //각 담당 역할의 인원수가 선택될 때 저장할 배열
function addwTeam(){

	var wtb = document.getElementById('wtb');
	var row = wtb.insertRow(wcnt);
	
	row.innerHTML='<div>'
					+'<table>'
						+'<tr>'
							+'<td>'
								+'<img src="/sp/img/profile_default.jpg" style="width:50px;height:60px;">'
							+'</td>'
							+'<td style="border-bottom:0.5px gray dotted;">'
								+'<select name="wMainRole" onchange="select(this, \'inner\')" style="width:130px;height:25px; margin-top:10px">'
									+'<option selected>선택하기</option>'
									+'<option value="developer">개발자</option>'
									+'<option value="desiner">디자이너</option>'
									+'<option value="planner">기획자</option>'
									+'<option value="etc">etc</option>'
								+'</select>'
								+'<input style="width:170px;height:20px;margin-left:10px;" type="text" class="wDetailRole" name="wDetailRole" required="required" >'
								+'<div style="font-size:11px; color:#D20505;">해당 담당 역할이 없는경우 직접 작성해주세요. (1개 선택 가능)</div>'
								+'<div id="btnDivnowTeam" style="width:300px"></div>'
								+'<div>'
									+'필요 능력 사항 : '
									+'<input style="width:170px;height:20px;margin-left:10px; margin-bottom:10px; margin-top:10px" type="text" name="requiredAbility" placeholder="빈칸으로 두셔도 됩니다">'
								+'</div>'
							+'</td>'
							+'<td style="border-bottom:0.5px gray dotted;">'
								+' 인원 수 '
								+'<select name="wantedNumber" onchange="cntwTeam(this)">'
									+'<option value="0" selected>선택하세요</option>'
									+'<option value="1" >1명</option>'
									+'<option value="2">2명</option>'
									+'<option value="3">3명</option>'
									+'<option value="4">4명</option>'
								+'</select>'
								+'<input style="text" hidden="" name="recruitedNumber" value="0">'
							+'</td>'
							+'<td style="border-bottom:0.5px gray dotted;">'
								+'<input type="button" value="-" onclick="delwTeam(this);" style="margin-left:20px"> 삭제'									
							+'</td>'
						+'</tr>'	
					+'</table>'
				+'</div>'
	wpeople.push(0); //테이블 생성하면 인원수 계산하는 배열에 인원수 1 넣어주기
	wcnt++;
}

function delwTeam(row){ //팀원 삭제하는 함수

	var idx = row.parentNode.parentNode.rowIndex; //삭제 눌린 해당 인덱스 찾기
	var wtb = document.getElementById('wtb');
	wtb.deleteRow(idx); //인덱스에 해당하는 줄 지우기
	wpeople.splice(idx,1); //테이블 삭제되면 해당 인덱스에 해당하는 인원수 넣은 배열 삭제
	wcnt--;
	
	var sum=0;
	for(var i=0;i<wcnt;i++){
		sum += Number(wpeople[i]);
	}
	document.all.sumwTeam.value=sum;
	
}

function cntwTeam(count){ //셀렉트 박스 변경될 때 마다 인원수 측정하여 변경해주는 함수
	var sum=0;
	var idx = count.parentNode.parentNode.rowIndex; //select box가 선택된 해당 인덱스
	for(var i=0;i<wcnt;i++){
		if(i==idx){
			wpeople[i]=count.value;
		}
	}
	for(var i=0;i<wcnt;i++){
		sum += Number(wpeople[i]);
	}
	document.all.sumwTeam.value=sum;
}
function ageNoMatter(cb){ //나이 무관인 경우 나이 입력할 수 있는 text칸 숨기기
	if(cb.checked==true){
		document.all.ageVisible.style.display="none";
		CompetitionMoimMake.ageRestriction.value="무관"; //무관 데이터 db로 저장되도록 설정
	}else{
		document.all.ageVisible.style.display="";
		CompetitionMoimMake.ageRestriction.value="";
	}
}
function setEquipTech(obj){
	var et = CompetitionMoimMake.equipTech;
	if(obj.checked == true){
		et.readOnly = true;
		et.value = "";
	}else{
		et.readOnly = false;
	}
}
function checkLength(obj){
	var textvalue = new String(obj.value); // textarea에 입력된 문자열
	var tcount = 0; //입력된 값의 길이를 구할 변수

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
	
	obj.nextSibling.nextSibling.value= tcount+'/2990bytes';
}
function formcheck(){
	//넘어가는 값 null 체크하기
	if(CompetitionMoimMake.matchName.value == ""){
		alert(CompetitionMoimMake.matchName.value);
		alert('모임명을 입력해주세요');
		CompetitionMoimMake.matchName.focus();
		return false;
	}else if(CompetitionMoimMake.mainRole.value == ""){
		alert('역할을 선택해주세요');
		CompetitionMoimMake.mainRole.focus();
		return false;
	}else if(CompetitionMoimMake.detailRole.value == ""){
		alert('상세 역할을 입력해주세요');
		CompetitionMoimMake.detailRole.focus();
		return false;
	}else if(CompetitionMoimMake.sido.value == ""){
		alert('지역을 선택해주세요');
		CompetitionMoimMake.sido.focus();
		return false;
	}else if(CompetitionMoimMake.sigungu.value == ""){
		alert('상세 지역을 입력해주세요');
		CompetitionMoimMake.sigungu.focus();
		return false;
	}else if(CompetitionMoimMake.timesAWeek.value == ""){
		alert('주 몇 회인지 입력해주세요');
		CompetitionMoimMake.timesAWeek.focus();
		return false;
	}else if(CompetitionMoimMake.day.value == ""){
		alert('가능한 요일/시간대를 입력해주세요');
		CompetitionMoimMake.day.focus();
		return false;
	}else if(CompetitionMoimMake.totalWantedNumber.value == 0){
		alert('구하는 인원 수을 입력해주세요');
		CompetitionMoimMake.totalWantedNumber.focus();
		return false;
	}
	
	
	CompetitionMoimMake.memberIx.value = <%=member_ix%>;
	CompetitionMoimMake.competitionInfoIx.value = <%=com_ix%>;
	CompetitionMoimMake.cnt.value = cnt;
	CompetitionMoimMake.wcnt.value = wcnt;

	return true;
}
</script>
</head>
<body>
<%@include file="/header.jsp"%>
<section>
	<article>
		<form name="CompetitionMoimMake" action="CompetitionMoimMake_ok.jsp" onsubmit="return formcheck();" method="post">
		<input type="text" hidden="" name="memberIx">
		<input type="text" hidden="" name="competitionInfoIx">
		<input type="text" hidden="" name="cnt">
		<input type="text" hidden="" name="wcnt">
		<p style="font-size: 30px; font-weight: bold;" align="center">모임을 개설하려는 공모전 정보</p>
		<div id="compInfo" align="center">
			<table style="width:800px;height:250px;">
				<tr>
					<td style="width:200px;height:250px;" rowspan="9"><img style="width:200px;height:250px;border: 1px solid gray; margin-right:30px;" src="/sp/img/content.jpg"></td>
				</tr>
				<tr>
					<td colspan="2" style="font-size:20px;">어촌 사랑 초등학생 공모전</td>
				</tr>
				<tr>
					<td class="sub">분야</td>
					<td>디자인</td>
				</tr>
				<tr>
					<td class="sub">팀/개인</td>
					<td>개인</td>
				</tr>
				<tr>
					<td class="sub">주최</td>
					<td>고용노동부</td>
				</tr>
				<tr>
					<td class="sub">주관</td>
					<td>방송통신위원회, 안전보건공단</td>
				</tr>
				<tr>
					<td class="sub">참가자격</td>
					<td>초등학생</td>
				</tr>
				<tr>
					<td class="sub">접수기간</td>
					<td>2018-12-21 ~ 2019-01-30</td>
				</tr>
				<tr>
					<td class="sub">홈페이지</td>
					<td><a>홈페이지 링크 걸기</a></td>
				</tr>
			</table>
		</div>
		<div class="bodytype2">
			<p style="font-size:25px; font-weight: bold;">모임명
			<input style="margin-left:20px;width: 300px;height:25px;" type="text" name="matchName" placeholder="ex)모두의 게임, 대상소리, 자동문" required="required">
			</p>
			<p style="text-align:left;font-size:25px; font-weight: bold;">모임 개설자 소개</p>
			<table style="width:800px;height:200px;text-align:left;">
				<tr>
					<td rowspan="4" style="width:120px"><img src="<%=imagpath %>" id="pfimg">
					<input style="width:90px; font-size:11px;" type="button" value="사진 수정하기" onclick="javascript:location.href='/sp/mypage/myProfile.jsp'">
					</td>
					<th style="width:150px;height:80px;">담당 역할</th>
					<td>
					<select name="mainRole" onchange="select(this, 'outer')" style="width:130px;height:25px;" required="required">
						<option selected value="">선택하기</option>
						<option value="developer">개발자</option>
						<option value="desiner">디자이너</option>
						<option value="planner">기획자</option>
						<option value="etc">etc</option>
					</select>
					<input style="width:170px;height:20px;" type="text" id="dRole" name="detailRole" required="required">
					<div style="font-size:11px; color:#D20505;">해당 담당 역할이 없는경우 직접 작성해주세요. (1개 선택 가능)</div>
					<div id="btn"></div>
					</td>
				</tr>
				<tr>
					<th>분야/전공</th>
					<td><input style="height:25px;" type="text" name="field" readonly="readonly" placeholder="DB값" value="<%=memberdto.getFieldMajor()%>"></td>
				</tr>
				<tr>
					
					<th>출생년도</th>
					<td><input style="height:25px;" type="text" name="birthYear" readonly="readonly" placeholder="DB값" value="<%=birthyear%>"></td>
				</tr>
				<tr>
					
					<th>공모전 경력 여부</th>
					<td>
						<%if(len>0){out.print("있음");}else{out.print("없음");} %>
					</td>
				</tr>
			</table>
		</div>
		<div class="bodytype" align="center">
			<p style="text-align:right;">
				<input type="button" value="공모전 내역 수정하기" onclick="javascript:location.href='/sp/mypage/myProfile.jsp'">
			</p>
			<%
				for(int i=0; i<len;i++){ 
					String mainrole = manageNull(list.get(i).getMainRole());
					String detailrole = manageNull(list.get(i).getDetailRole());
					String award = manageNull(list.get(i).getAward());
					String detail = manageNull(list.get(i).getDetail());
			%>
			<table border="1" cellspacing="0" style="width:700px;height:240px; tex">
				<tr>
					<th style="width:150px;height:25px;">공모전 이름</th>
					<td style="width:550px;height:25px; padding-left: 6px;" colspan="3" ><%=list.get(i).getCName() %></td>
				</tr>
				<tr>
					<th>공모전 기간</th>
					<td style="width:550px;height:25px; padding-left: 6px;" colspan="3"><%=list.get(i).getPeriod() %></td>
				</tr>
				<tr>
					<th>수상 내역</th>
					<td style="padding-left: 6px;"><%=award %></td>
					<th style="width:150px;height:25px;">담당 역할</th>
					<td style="padding-left: 6px;"><%=mainrole+" - "+detailrole %></td>
				</tr>
				<tr>
					<th rowspan="3">상세 내용</th>
					<td rowspan="3" colspan="3" style="padding-left: 6px;"><pre><%=detail %>></pre></td>
				</tr>
			</table>
			<%} %>
		</div>
		<div class="bodytype">
			<div style="font-size:25px;font-weight: bold;margin-bottom:15px;">현재 구성된 팀원</div>
			<div>현재 구성된 팀원이 존재합니까?
				<input type="radio" name="team" value="yes" onchange="nowTeam(this.value);">예
				<input type="radio" name="team" value="no" onchange="nowTeam(this.value)" checked>아니오
			</div>
			<div id="nowTeamMember" style="display: none;">
				<h5 style="color:gray;">현재 팀원의 역할을 간단하게 소개해주세요</h5>
				<table style="width:800px;border:1px gray dotted;">
					<tbody id="tb">
					</tbody>
					<tr>
					<td colspan="5" style="font-size:15px;"><input type="button" value="+" onclick="addTeam();"> 팀원 추가하기</td>
					</tr>
				</table>
				<h3>현재 구성된 총 팀원 수 : <input type="text" id="sumTeam" name="originalMemberNumber" value="0" style="font-size:20px;width:30px;border:0px;" readonly="readonly">명</h3>
			</div>
		</div>
		<div class="bodytype">
			<div style="font-size:25px;font-weight: bold;">이런 지역/요일에 모임을 가지고 싶어요</div>
			<p>지역 선택
			<select onchange="addOption(this)" name="sido" style="width:130px;height:25px;">
				<option selected value="">선택해주세요</option>
				<option>서울특별시</option>
				<option>인천광역시</option>
				<option>대구광역시</option>
				<option>부산광역시</option>
				<option>광주광역시</option>
				<option>대전광역시</option>
				<option>울산광역시</option>
				<option>세종시</option>
				<option>경기도</option>
				<option>강원도</option>
				<option>충청남도</option>
				<option>충청북도</option>
				<option>경상북도</option>
				<option>경상남도</option>
				<option>전라북도</option>
				<option>전라남도</option>
				<option>제주도</option>
			</select>
			<select hidden="" name="sigungu" style="width:130px;height:25px;"> <!-- 추가옵션 달릴 부분 -->
				<option selected value="">선택해주세요</option>
			</select>
			</p>
			주
			<select style="width:80px;height:25px;" name="timesAWeek">
				<option value="" selected>선택</option>
				<option value="1회">1회</option>
				<option value="2회">2회</option>
				<option value="3회">3회 이상</option>
			</select>
			<input style="width:230px;height:22px;" type="text" name="day" placeholder="가능한 요일/시간대 작성" required="required">
		</div>
		<div class="bodytype">
			<div style="font-size:25px;font-weight: bold;margin-right: 40px;margin-bottom:15px;">이런 사람을 구하고 있어요</div>
			<span>나이</span>
			<span id="ageVisible" style="display: none;"><input style="width:45px;height:25px;margin-left:10px;" type="text" name="ageRestriction" value="무관">세 이하</span>
			<span><input style="width:20px;height:20px;" type="checkbox" onclick="ageNoMatter(this)" checked> 무관</span>
			<!-- 인원 추가하는 모듈 만들자 -->
			<div id="wantTeamMember" >
				<h5 style="color:gray;">원하는 팀원의 역할을 간단하게 작성해주세요</h5>
				<table style="width:800px;border:1px gray dotted;">
					<tbody id="wtb">
					</tbody>
					<tr>
					<td colspan="5" style="font-size:15px;"><input type="button" value="+" onclick="addwTeam();"> 팀원 추가하기</td>
					</tr>
				</table>
				<h3>현재 원하는 총 팀원 수 : <input type="text" id="sumwTeam" name="totalWantedNumber" value="0" style="font-size:20px;width:30px;border:0px;" readonly="readonly">명</h3>
			</div>
		</div>
		<div class="bodytype">
			<div style="margin-top:15px;margin-bottom:15px;"><font style="font-size:25px;font-weight:bold;margin-right:300px;">이런 기술/장비를 다뤄보고 싶어요</font>
			<input style="width:20px;height:20px;" type="checkbox" value="추후 지정" onclick="setEquipTech(this);">추후 지정</div>
			<textarea style="width:800px; height: 150px;" placeholder="공모전에서 다루고 싶은 기술/장비 관련 세부사항이 있다면 작성해주세요." name="equipTech" onkeyup="checkLength(this);"></textarea>
			<input style="background: none; border: none;" type="text" >
		</div>
		<div class="bodytype2">
			<div style="font-size:25px;font-weight:bold;margin-bottom:15px;">공모전 모임 상세 소개</div>
			<textarea style="width:800px; height: 150px;" placeholder="소개하고 싶은 모임 관련 정보를 작성해주세요.&#13;&#10;EX)입선 이상을 목표로 열심히 진행중입니다." name="detail" onkeyup="checkLength(this);"></textarea>
			<input style="background: none; border: none;" type="text">
		</div>
		<div style="text-align:center;">
				<input class="btn" type="submit" value="모임 만들기">
				<input class="btn" type="button" value="취소">
		</div>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>