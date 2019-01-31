<%@ page import="match.*" %>
<%@ page import="member.*" %>
<%@ page import="competition.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="cdao" class="competition.CompetitionInfoDAO"/>
<jsp:useBean id="mbdao" class="member.MemberDAO"/>
<jsp:useBean id="mdao" class="match.MatchDAO"/>
<jsp:useBean id="mwdao" class="match.MatchWantedDAO"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공모전 매칭사이트</title>
<link rel="stylesheet" type="text/css" href="css/mainLayout.css">
<style>
.main_title{
	text-align:center;
	font-size:25px;
	font-weight:bold;
}
.main_body_1{
	width: 490px;
	height: auto;
	float: left;
	margin-left: 200px;
}
.main_body_2{
	width: 490px;
	height: auto;
	float: left;
	margin-left: 20px;
}
.main_table_1{
	float:left;
	margin-left:100px;
}
.main_table_2{
	float:left;
	margin-left:40px;
}
table th{
	background: #424242;
	color:white;
	border-top: 0.5px solid black;
	border-bottom: 0.5px solid black;
	border-spacing:0px;
}
tbody h2{
	background: #424242;
	color: white;
	padding: 9px;
	text-align: center;
}
tbody a{
	text-decoration:none;
	cursor: pointer;
	color: black;
	font-weight: bold;
}
tbody a:hover{
	background: #BDBDBD;
	font-weight: bold;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
	<article>
		<div id="main">
			<div class="main_title"><h1>공모전 팀원 찾기 사이트</h1></div>
			<div class="main_body_1">
				<h2>최근 올라온 공모전 5개</h2>
			</div>
			<div class="main_body_2">
				<h2>조회수 많은 공모전 5개</h2>
			</div>
			<div class="main_table_1">
				<table style="width:480px;height:auto;" border="1" cellspacing="0">
					<thead>
						<tr>
							<th style="width:110px;">분류</th>
							<th style="width:300px;">제목</th>
							<th style="width:70px;">조회수</th>
						</tr>
					</thead>
					<tbody>
						<%
						ArrayList<CompetitionInfoDTO> arr2=cdao.CompetitonRecent();
						if(arr2==null||arr2.size()==0){
							%>
							<tr>
								<td colspan="3"><h2>공모전이 등록되지 않았습니다.</h2></td>
							</tr>
							<%
						}else{
							for(int i=0;i<arr2.size();i++){
								%>
								<tr>
									<td style="text-align:center;"><%=arr2.get(i).getField()%></td>
									<td style="width:300px;padding-left:10px;"><a href="/sp/Competition/CompetitionDetail.jsp?ix=<%=arr2.get(i).getCompetitionInfoIx()%>"><%=arr2.get(i).getCName()%></a></td>
									<td style="text-align:center;"><%=arr2.get(i).getReadnum()%></td>
								</tr>
								<%
							}
						}
						%>
					</tbody>
				</table>
			</div>
			<div class="main_table_2">
				<table style="width:480px;height:auto;" border="1" cellspacing="0">
					<thead>
						<tr>
							<th style="width:110px;">분류</th>
							<th style="width:300px;">제목</th>
							<th style="width:70px;">조회수</th>
						</tr>
					</thead>
					<tbody>
						<%
						ArrayList<CompetitionInfoDTO> arr=cdao.CompetitionManyReadnum();
						if(arr==null||arr.size()==0){
							%>
							<tr>
								<td colspan="3"><h2>공모전이 등록되지 않았습니다.</h2></td>
							</tr>
							<%
						}else{
							for(int i=0;i<arr.size();i++){
								%>
								<tr>
									<td style="text-align:center;"><%=arr.get(i).getField()%></td>
									<td style="width:300px;padding-left:10px;"><a href="/sp/Competition/CompetitionDetail.jsp?ix=<%=arr.get(i).getCompetitionInfoIx()%>"><%=arr.get(i).getCName()%></a></td>
									<td style="text-align:center;"><%=arr.get(i).getReadnum()%></td>
								</tr>
								<%
							}
						}
						%>
					</tbody>
				</table>
			</div>
			<div class="main_body_1">
				<h2>최근 올라온 모임 5개</h2>
			</div>
			<div class="main_body_2">
				<h2>최근 등록된 사람 5명</h2>
			</div>
			<div style="float:left;margin-left:120px;">
				<table style="width:420px;height:auto;text-align:center;" border="1" cellspacing="0">
					<thead>
						<tr>
							<th>모임명</th>
							<th>구하는 역할/구하는 인원수</th>
						</tr>
					</thead>
					<tbody>
						<%
						ArrayList<MatchDTO> marr=mdao.RecentMoimAllList();
						if(marr==null||marr.size()==0){
							%>
							<tr>
								<td colspan="3"><h2>최근 등록된 모임이 없습니다.</h2></td>
							</tr>
							<%
						}else{
							for(int i=0;i<marr.size();i++){
								int match_ix=marr.get(i).getMatchIx();
								ArrayList<MatchWantedDTO> mwarr=mwdao.MatchAddPeople(match_ix);
								%>
								<tr>
									<td style="width:150px;"><a href="/sp/Competition/CompetitionDetail.jsp?ix=<%=marr.get(i).getCompetitionInfoIx()%>&mix=<%=match_ix%>"><%=marr.get(i).getMatchName()%></a></td>
									<td style="width:270px;">
								<%
								for(int j=0;j<mwarr.size();j++){
										String a=mwarr.get(j).getwDetailRole();
										String b=mwarr.get(j).getWantedNumber();
									if(j>=2){
										%>&middot;&middot;&middot;<%
										break;
									}
									%>
									<%=a%>&nbsp;<%=b%>
								<%
								}
								%>
								</td>
								</tr>
								<%
							}
						}
						%>
					</tbody>
				</table>
			</div>
			<div style="float:left;margin-left:163px;">
				<table style="width:270px;height:auto;text-align:center;margin-bottom: 50px;" border="1" cellspacing="0">
					<thead>
						<tr>
							<th>이름</th>
							<th>분야/전공</th>
						</tr>
					</thead>
					<tbody>
						<%
						ArrayList<MemberDTO> mbarr=mbdao.RecentPeople();
						if(mbarr==null||mbarr.size()==0){
							%>
							<tr>
								<td colspan="2"><h2>최근 등록된 사람이 없습니다.</h2></td>
							</tr>
							<%
						}else{
							for(int i=0;i<mbarr.size();i++){
								%>
								<tr>
									<td style="width:70px;"><a href="/sp/humansearch/humanSelect.jsp?member_ix=<%=mbarr.get(i).getMemberIx()%>"><%=mbarr.get(i).getMName()%></a></td>
									<td style="width:200px;"><%=mbarr.get(i).getFieldMajor()%></td>
								</tr>
								<%
							}
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</article>
<%@include file="/footer.jsp" %>
</section>
</body>
</html>