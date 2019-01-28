<%@page import="member.MemberDAO"%>
<%@page import="competition.CompetitionScrapDAO"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="match.MatchDTO"%>
<%@ page import="competition.CompetitionInfoDTO" %>
<%@ page import="match.MatchWantedDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="match.MatchDAO"/>
<jsp:useBean id="cdao" class="competition.CompetitionInfoDAO"/>
<jsp:useBean id="mwdao" class="match.MatchWantedDAO"/>
<%
// 공모전 제목 클릭시 Competition_Info_IX인덱스로 값 받아오기
String ix_s=request.getParameter("ix");
if(ix_s==null||ix_s.equals("")){
	ix_s="0";
}
int ix=Integer.parseInt(ix_s);

//모임 카드 클릭한 경우, 모임의 인덱스 가져오기
String mix_s=request.getParameter("mix");
if(mix_s==null||mix_s.equals("")){
	mix_s="-1";
}
int mix=Integer.parseInt(mix_s);

//공모전 제목 클릭시 정보보기 CompetitionInfoDAO
CompetitionInfoDTO dto=cdao.CompetitionCNameInfo(ix);

//여러개의 공모전 모임카드 데이터베이스 DAO 구성
ArrayList<MatchDTO> arr=mdao.MoimCardAllList(ix);

//본인 인덱스 가져오는 메소드
String crt_id = (String)session.getAttribute("sidEmail");
MemberDAO dao = new MemberDAO();
int idx=dao.getMemberIndex(crt_id);

//
CompetitionScrapDAO csdao = new CompetitionScrapDAO();
boolean scrapcheck = csdao.checkScrapComp(idx, ix);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
.sub {
	font-weight: bold;
}

#Competition_title {
	width: 800px;
	margin-top: 10px;
	background: #D8D8D8;
	color: black;
	font-size: 30px;
	font-weight: bold;
	text-align: center;
}
td.hvr:hover, td.hvr:active{
	color:#585858;
	cursor: pointer;
}

article {
	width: 800px;
	margin-left: 100px;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/Competition/aside.jsp" %>
<section>
	<article>
		<div>
			<table style="width:800px;height:250px;">
				<tr>
					<td style="width:200px;height:250px;" rowspan="9"><img style="width:200px;height:250px;border: 1px solid gray; margin-right:30px;" src="/sp/img/content/<%=dto.getCImage()%>"></td>
				</tr>
				<tr>
					<td colspan="4" style="font-size:20px;"><%=dto.getCName()%></td>
				</tr>
				<tr>
					<td class="sub">분야</td>
					<td><%=dto.getField()%></td>
					<td rowspan="3" colspan="2">
					<form name="CompScrapCheck" action="CompScrapCheck_ok.jsp" method="post">
						<input type="image" src="<%if(scrapcheck){out.print("/sp/img/heart.jpg");}else{out.print("/sp/img/unheart.jpg");} %>" style="width:60px;height:60px;">
						<input type="hidden" value="<%=idx %>" name="user_ix">
						<input type="hidden" value="<%=ix %>" name="comp_ix">
						<input type="hidden" value="<%=scrapcheck %>" name="scrapcheck">
					</form>
					</td>
					
				</tr>
				<tr>
					<td class="sub">팀/개인</td>
					<td><%=dto.getTeamSolo()%></td>
				</tr>
				<tr>
					<td class="sub">주최</td>
					<td><%=dto.getAuspice()%></td>
				</tr>
				<tr>
					<td class="sub">주관</td>
					<td><%=dto.getCManage()%></td>
				</tr>
				<tr>
					<td class="sub">참가자격</td>
					<td><%=dto.getEntitlement()%></td>
				</tr>
				<tr>
					<td class="sub">접수기간</td>
					<td><%=dto.getPeriod()%></td>
				</tr>
				<tr>
					<td class="sub">홈페이지</td>
					<td><a><%=dto.getCLink()%></a></td>
				</tr>
			</table>
		</div>
		<!-- 현재 생성된 모임 | 공모전 상세보기 -->
		<div>
			<table id="Competition_title">
			<tr>
				<td class="hvr" style="border-right:1px gray solid" 
					onclick="javascript:location.href='CompetitionDetail.jsp?ix=<%=ix%>'">현재 생성된 모임</td>
				<td class="hvr" >공모전 상세보기</td>
			</tr>
			</table>
		</div>
		<!-- 내부 영역 -->
		<div align="center">
		<!-- 현재 생성된 모임 클릭 시 -->
		<%
		if(ix==0){
			%>
			<script>
			window.alert('공모전이 삭제되었거나 잘못된 접근입니다.');
			location.href='/sp';
			</script>
			<%
		}else if(mix==-1){
			%>
			<p align="right"><a href="/sp/Competition/CompetitionMoimMake.jsp?ix=<%=ix%>"><input style="height:35px;" type="button" value="모임 생성하기"></a></p>
			<%@include file="/Competition/CompetitionMoimCard.jsp"%>
			<%
		}else{
			%>
			<%@include file="/Competition/CompetitionMoimSelect.jsp"%>
			<%
		}
		%>
		<!-- 공모전 상세보기 클릭 시 -->
		</div>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>