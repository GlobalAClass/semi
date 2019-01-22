<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%@page import="hsearch.*" %>
<%@page import="java.io.File"%>

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
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사람 검색</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
select{
	width:170px;
	height:35px;
}
input{
	width:100px;
	height:35px;
}
input[type="text"]{
	width:170px;
	height:30px;
}
</style>
</head>
<script type="text/javascript">
//지역 선택시에 추가 옵션 보여주는 함수.
function addOption(obj){
	var option = obj.value; 
	var ary; 
	var addop = humanSearch.sigungu;
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
			humanSearch.sigungu.add(op);
		}
		humanSearch.sigungu.hidden=false;
	}else{
		humanSearch.sigungu.hidden=true;
	}
}
function fieldMajorPop(){
	var popwidth = 500; //팝업창 가로 길이 설정
	var popheight = 500; //팝업창 가로 길이 설정
	//윈도우창의 크기 절반, 팝업창의 크기 절반 수치
	var popupX = (window.screen.availWidth-popwidth)/2; 
	var popupY = (window.screen.availHeight-popheight)/2; 
	window.open('/sp/memberJoin/fieldMajorPop.jsp', 'fieldMajorPop', 'width='+popwidth+', height='+popheight
				+',left='+popupX + ', top='+ popupY );
}
function search(){
	var sido = humanSearch.sido.value;
	var sigungu = humanSearch.sigungu.value;
	var fieldMajor = humanSearch.fieldMajor.value;
	location.href = '/sp/humansearch/humanSearch.jsp?sido='+sido+'&sigungu='+sigungu+'&fieldMajor='+fieldMajor;
}
function scrap(obj){
	var displaystate = obj.style.display;
	if(displaystate == "block"){
		displaystate = "none";
	}else{
		displaystate = "block";
	}
}
</script>
<%
	//jsp:로 받는 것은 포스트방식이기때문에 설정해 줘야 함.
	request.setCharacterEncoding("UTF-8");

	String sido_str = request.getParameter("sido");
	String sigungu_str = request.getParameter("sigungu");
	String fieldMajor_str = request.getParameter("fieldMajor");
	
	HsearchDAO hdao = new HsearchDAO();
	
	ArrayList<Pair<MemberDTO, MemberDetailDTO>> searchlist = hdao.searchHuman(sido_str, sigungu_str, fieldMajor_str);
%>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<form action="" name="humanSearch">
				<select style="font-size:15px;margin-bottom:10px;" onchange="addOption(this)" name="sido">
					<option selected value="">전체 지역</option>
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
				<select <%if(sigungu_str==null || sigungu_str.equals("")){out.print("hidden");} %> name="sigungu" > <!-- 추가옵션 달릴 부분 -->
					<option selected value="">전체 지역</option>
				</select>
				<input <%if(fieldMajor_str!=null && !fieldMajor_str.equals("")){out.print("value='"+fieldMajor_str+"'");} %> 
						type="text" placeholder="분야/전공 검색"  name="fieldMajor" >&nbsp;
				<input type="button" value="분야/전공 찾기" onclick="fieldMajorPop()">
				<input type="button" value="사람 찾기" style="float: right" onclick="search()">
				<input type="button" value="나도 등록하기!" style="float: right; margin-right: 20px;" >
			</form>
			<script>//사람찾기 검색조건 유지.
				var sido = humanSearch.sido;
				for(i=0; i<sido.length;i++){
					if(sido.options[i].value == "<%=sido_str%>"){
						sido.options[i].selected = true;
					}
				}
				addOption(sido);
				var sigungu = humanSearch.sigungu;
				for(i=0; i<sigungu.length;i++){
					if(sigungu.options[i].value == "<%=sigungu_str%>"){
						sigungu.options[i].selected = true;
					}
				}
			</script>
		</article>
	</section>
	<section>
	<article style="margin:20px;">
	<%
	MemberDAO mdao = new MemberDAO();
	int u_ix = mdao.getMemberIndex(uid);
	
	if(searchlist!=null){
		int len = searchlist.size();
		for(int i=0; i<len; i++){
	%>
			<jsp:include page="humanCard.jsp" flush="false">
				<jsp:param value="<%=i %>" name="i" />
				<jsp:param value="<%=u_ix %>" name="user_ix" /> 
				<jsp:param value="<%=searchlist.get(i).getLeft().getMemberIx() %>" name="member_ix"/> 
				<jsp:param value="<%=searchlist.get(i).getLeft().getMName() %>" name="mName"/>
				<jsp:param value="<%=searchlist.get(i).getRight().getBirthYear() %>" name="birth"/>
				<jsp:param value="<%=searchlist.get(i).getLeft().getFieldMajor() %>" name="fieldMajor"/>
				<jsp:param value="<%=searchlist.get(i).getRight().getSido() %>" name="sido"/>
				<jsp:param value="<%=searchlist.get(i).getRight().getSigungu() %>" name="sigungu"/>
				<jsp:param value="<%=searchlist.get(i).getLeft().getidEmail()%>" name="idEmail"/>
			</jsp:include>
	<%
		}
	} 
	%>
	</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>