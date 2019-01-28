<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="member.MemberDAO"%>
<%@ page import="competition.*" %>	
<%@ page import="member.*" %>
<%@ page import="msearch.*" %>
<%@ page import="match.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="msdao" class="msearch.MsearchDAO"/>
<jsp:useBean id="mwdao" class="match.MatchWantedDAO"/>
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
	
//여러개의 공모전 모임카드 데이터베이스 DAO 구성
ArrayList<MatchDTO> arr=msdao.MoimSearchCard();
for(int k=0;k<arr.size();k++){
	int matchIx=arr.get(k).getMatchIx();
	CompetitionInfoDTO dto=msdao.CompetitionMoimSearchCard(matchIx);
}
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
function addOption(obj){
	var option = obj.value;
	var ary;
	var addop = moimSearch.sigungu;
	if(addop.length>1){
		for(i=0;i<addop.length;i++){
			addop.length=1;	
		}
	}
	//선택한 지역에 따라 추가 옵션을 다르게 함
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
function input(){
	var wdf=document.all.developer.value;
	document.moimSerch.wDetailRole.value=wdf;
}
</script>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	String sido_s=request.getParameter("sido");
	String sigungu_s=request.getParameter("sigungu");
	String wDetailRole_s=request.getParameter("wDetailRole");
%>
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
				<option selected>공모전</option>
				<option>광고/마케팅</option>
				<option>기획/아이디어</option>
				<option>디자인</option>
				<option>UCC/영상</option>
				<option>과학/공학/IT</option>
				<option>그 외 공모전</option>
			</select>
			<select id="part" onchange="select()">
				<option selected>담당 역할</option>
				<option value="developer">개발자</option>
				<option value="desiner">디자이너</option>
				<option value="planner">기획자</option>
				<option value="etc">etc</option>
			</select>
			<input type="text" style="height:30px;margin-left:10px;" placeholder="세부역할" id="wDetailRole">
			<input type="button" value="모임 검색" style="float:right;width:100px;height:30px;">
			<input type="button" value="모임 등록하기" style="float:right;margin-right: 15px;width:100px;height:30px;">
			<br><br><br>
			</form>
			<form id="developer" style="display: none;">
				<input type="button" value="서버" onchange="input()">
				<input type="button" value="DB">
				<input type="button" value="블록체인">
				<input type="button" value="클라우드">
				<input type="button" value="빅데이터">
				<input type="button" value="데이터 분석">
				<input type="button" value="IOS">
				<input type="button" value="안드로이드">
				<input type="button" value="WEB">
			</form>
			<form id="desiner" style="display: none;">
				<input type="button" value="UI/UX디자인">
				<input type="button" value="일러스트">
				<input type="button" value="에프터이펙트">
				<input type="button" value="포토샵">
				<input type="button" value="3D MAX">
				<input type="button" value="웹툰">
				<input type="button" value="프로토타이핑">
				<input type="button" value="BI디자인">
			</form>
			<form id="planner" style="display: none;">
				<input type="button" value="기획">
				<input type="button" value="마케팅">
				<input type="button" value="컨텐츠 제작">
				<input type="button" value="SNS">
				<input type="button" value="온라인 마케팅">
			</form>
			<form id="etc" style="display: none;">
				<input type="button" value="영상 제작">
				<input type="button" value="영상 촬영">
				<input type="button" value="영상 편집">
				<input type="button" value="통계 분석">
				<input type="button" value="아이디어">
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