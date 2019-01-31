<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="competition.*" %>	
<%@ page import="member.*" %>
<%@ page import="msearch.*" %>
<%@ page import="match.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="msdao" class="msearch.MsearchDAO"/>
<%
	//로그인해야 해당 페이지를 이용할 수 있음.
	String uname=(String)session.getAttribute("smname");
	String uid=(String)session.getAttribute("sidEmail");
	
	if(uname==null||uname.equals("")||uid==null||uid.equals("")){
		%>
		<script>
			alert("로그인하셔야 이용하실 수 있습니다.");
			location.href="/sp/login.jsp";
		</script>
		<%
		return;
	}
	
//해당페이지 url 값 받기 시도 / 시군구 / 분야 / 세부역할
request.setCharacterEncoding("UTF-8");

String sido_s=request.getParameter("sido");
String sigungu_s=request.getParameter("sigungu");
String C_Field_s=request.getParameter("C_Field");
String wMainRole_s=request.getParameter("part");
String wDetailRole_s=request.getParameter("wDetailRole");
	
//여러개의 공모전 모임카드 데이터베이스
ArrayList<Pairs<CompetitionInfoDTO,MatchDTO,MatchWantedDTO>> search =msdao.MoimSearch(sido_s,sigungu_s,C_Field_s,wMainRole_s,wDetailRole_s);
//본인 인덱스 가져오는 메소드
String crt_id = (String)session.getAttribute("sidEmail");
MemberDAO dao = new MemberDAO();
int idx=dao.getMemberIndex(crt_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 검색</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
section select{
	font-size: 15px;
	margin-left:10px;
	float: left;
	margin-bottom: 20px;
	width:120px;
	height: 35px;
}
form{
	margin-left:10px;
	float: left;
}
input{
	width:100px;
	height:28px;
}
input[type="text"]{
	width:120px;
	height:35px;
}
</style>
<script type="text/javascript">
//선택한 지역에 따라 추가 옵션을 다르게 함.
function addOption(obj){
	var option = obj.value;
	var ary;
	var addop = moimSearch.sigungu;
	if(addop.length>1){
		for(i=0;i<addop.length;i++){
			addop.length=1;	
		}
	}
	if(option =='서울특별시'){
		ary=['강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', 
			'동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', 
			'용산구', '은평구', '종로구', '중구', '중랑구 '];
		
		for(var i=0;i<ary.length;i++){
			var op=new Option();
			op.value = ary[i]
			op.text = ary[i];
			moimSearch.sigungu.add(op);
		}
		moimSearch.sigungu.hidden=false;
	}else{
		moimSearch.sigungu.hidden=true;
	}
}
//담당역할 선택시 화면에 세부역할 보여주는 함수
function select(){
	var partname=document.all.part.value;//선택한 역할 값
	document.all.developer.style.display="none";
	document.all.desiner.style.display="none";
	document.all.planner.style.display="none";
	document.all.etc.style.display="none";
	switch(partname){
	case "developer":
		document.all.developer.style.display="";
		break;
	case "desiner":
		document.all.desiner.style.display="";
		break;
	case "planner":
		document.all.planner.style.display="";
		break;
	case "etc":
		document.all.etc.style.display="";
		break;
	}
	
}
//모임 검색
function search(){
	var sido = moimSearch.sido.value;
	var sigungu = moimSearch.sigungu.value;
	var C_Field = moimSearch.C_Field.value;
	var wMainRole= moimSearch.part.value;
	var wDetailRole=moimSearch.wDetailRole.value;
	location.href='/sp/moimsearch/moimSearch.jsp?sido='+sido+'&sigungu='+sigungu+'&C_Field='+C_Field+'&wMainRole='+ wMainRole+'&wDetailRole='+wDetailRole;
}
//기능 : 버튼 클릭시에 버튼 값이 자동으로 text에 입력
function input_text(wdr){
	var detail=wdr.value;
	document.moimSearch.wDetailRole.value=detail;
}
</script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<form action="" name="moimSearch">
			<select onchange="addOption(this)" name="sido">
				<option selected value="">전체지역</option>
				<option value="서울특별시">서울특별시</option>
				<option value="인천광역시">인천광역시</option>
				<option value="대구광역시">대구광역시</option>
				<option value="부산광역시">부산광역시</option>
				<option value="광주광역시">광주광역시</option>
				<option value="대전광역시">대전광역시</option>
				<option value="울산광역시">울산광역시</option>
				<option value="세종시">세종시</option>
				<option value="경기도">경기도</option>
				<option value="강원도">강원도</option>
				<option value="충청남도">충청남도</option>
				<option value="충청북도">충청북도</option>
				<option value="경상북도">경상북도</option>
				<option value="경상남도">경상남도</option>
				<option value="전라북도">전라북도</option>
				<option value="전라남도">전라남도</option>
				<option value="제주도">제주도</option>
			</select>
			<select <%if(sigungu_s==null||sigungu_s.equals("")){out.print("hidden");} %> name="sigungu">
				<option selected value="">전체 지역</option>
			</select>
			<select name="C_Field">
				<option selected value="">공모전</option>
				<option value="광고/마케팅">광고/마케팅</option>
				<option value="기획/아이디어">기획/아이디어</option>
				<option value="디자인">디자인</option>
				<option value="UCC/영상">UCC/영상</option>
				<option value="과학/공학/IT">과학/공학/IT</option>
				<option value="그 외 공모전">그 외 공모전</option>
			</select>
			<select id="part" onchange="select()">
				<option selected value="">담당 역할</option>
				<option value="developer">개발자</option>
				<option value="desiner">디자이너</option>
				<option value="planner">기획자</option>
				<option value="etc">etc</option>
			</select>
			<input type="text" style="height:30px;margin-left:10px;" placeholder="세부역할" id="wDetailRole">
			<input type="button" value="모임 검색" style="width:140px;height:35px;" onclick="search()">
			<br><br><br>
			</form>
			<form name="developer" style="display: none;">
				<input type="button" value="서버" onclick="input_text(this);">
				<input type="button" value="DB" onclick="input_text(this);">
				<input type="button" value="블록체인" onclick="input_text(this);">
				<input type="button" value="클라우드" onclick="input_text(this);">
				<input type="button" value="빅데이터" onclick="input_text(this);">
				<input type="button" value="데이터 분석" onclick="input_text(this);">
				<input type="button" value="IOS" onclick="input_text(this);">
				<input type="button" value="안드로이드" onclick="input_text(this);">
				<input type="button" value="WEB" onclick="input_text(this);">
			</form>
			<form id="desiner" style="display: none;">
				<input type="button" value="UI/UX디자인" onclick="input_text(this);">
				<input type="button" value="일러스트" onclick="input_text(this);">
				<input type="button" value="에프터이펙트" onclick="input_text(this);">
				<input type="button" value="포토샵" onclick="input_text(this);">
				<input type="button" value="3D MAX" onclick="input_text(this);">
				<input type="button" value="웹툰" onclick="input_text(this);">
				<input type="button" value="프로토타이핑" onclick="input_text(this);">
				<input type="button" value="BI디자인" onclick="input_text(this);">
			</form>
			<form id="planner" style="display: none;">
				<input type="button" value="기획" onclick="input_text(this);">
				<input type="button" value="마케팅" onclick="input_text(this);">
				<input type="button" value="컨텐츠 제작" onclick="input_text(this);">
				<input type="button" value="SNS" onclick="input_text(this);">
				<input type="button" value="온라인 마케팅" onclick="input_text(this);">
			</form>
			<form id="etc" style="display: none;">
				<input type="button" value="영상 제작" onclick="input_text(this);">
				<input type="button" value="영상 촬영" onclick="input_text(this);">
				<input type="button" value="영상 편집" onclick="input_text(this);">
				<input type="button" value="통계 분석" onclick="input_text(this);">
				<input type="button" value="아이디어" onclick="input_text(this);">
			</form>
			<script>//모임찾기 검색조건 유지
				var sido=moimSearch.sido;
				for(i=0;i<sido.length;i++){
					if(sido.options[i].value=="<%=sido_s%>"){
						sido.options[i].selected = true;
					}
				}
				addOption(sido);
				var sigungu=moimSearch.sigungu;
				for(i=0;i<sigungu.length;i++){
					if(sigungu.options[i].value=="<%=sigungu_s%>"){
						sigungu.options[i].selected = true;
					}
				}
			</script>
		</article>
	</section>
	<section>
	<article style="margin:20px;clear:both;">
	<%@include file="moimCard.jsp" %>
	</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>