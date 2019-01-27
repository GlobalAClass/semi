<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="competition.*"%>
<jsp:useBean id="cdto" class="competition.CompetitionInfoDTO"/>
<jsp:setProperty property="*" name="cdto"/>
<jsp:useBean id="cdao" class="competition.CompetitionInfoDAO"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
#main{
	float:left;
	width:1000px;
	height:auto;
}
#main thead th{
	background: #424242;
	color:white;
	border-top: 0.5px solid black;
	border-bottom: 0.5px solid black;
	border-spacing:0px;
}
h1{
	font-size: 30px;
	text-align: center;
	margin: 0px;
	padding: 9px;
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
tfoot a{
	text-decoration: none;
	color:#58ACFA;
}
</style>
</head>
<%
//전체 공모전 목록보기 페이징
int totalcnt=cdao.getTotalCnt();
int listsize=10;
int pagesize=10;
String cp_s=request.getParameter("cp");
if(cp_s==null||cp_s.equals("")){
	cp_s="1";
}
int cp=Integer.parseInt(cp_s);

int totalpage=totalcnt/listsize+1;
if(totalcnt%listsize==0){
	totalpage--;
}
int usergroup=cp/pagesize;
if(cp%pagesize==0){
	usergroup--;
}
%>
<body>
<%@include file="/header.jsp"%>
<%@include file="/Competition/aside.jsp"%>
<section>
	<article>
		<form name="Competition" >
		<div id="main">
		<h1>전체공모전</h1>
			<table style="width:800px;height:auto;margin-left:100px;" border="1" cellspacing="0">
				<thead>
					<tr>
						<th>분류</th>
						<th>제목</th>
						<th>접수기간</th>
						<th>팀/개인</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
				<%
				ArrayList<CompetitionInfoDTO> arr=cdao.CompetitionAllList(cp,listsize);
				if(arr==null||arr.size()==0){
					%>
					<tr>
						<td colspan="5"><h2>공모전이 등록되지 않았습니다.</h2></td>
					</tr>
					<%
				}else{
					for(int i=0;i<arr.size();i++){
						%>
						<tr>
							<td style="text-align:center;"><%=arr.get(i).getField()%></td>
							<td style="width:300px;padding-left:10px;"><a href="CompetitionDetail.jsp?ix=<%=arr.get(i).getCompetitionInfoIx()%>"><%=arr.get(i).getCName()%></a></td>
							<td style="width:200px;text-align:center;"><%=arr.get(i).getPeriod()%></td>
							<td style="text-align:center;"><%=arr.get(i).getTeamSolo()%></td>
							<td style="text-align:center;"><%=arr.get(i).getReadnum()%></td>
						</tr>
						<%
					}
				}
				%>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="5" align="center">
						<%
						if(usergroup!=0){
							%>
							<a href="Competition.jsp?cp=<%=(usergroup-1)*pagesize+pagesize%>">&lt;&lt;</a>
							<%
						}
						%>
						<%
						for(int i=usergroup*pagesize+1;i<usergroup*pagesize+pagesize;i++){
							%>
							&nbsp;&nbsp;<a href="Competition.jsp?cp=<%=i%>"><%=i%></a>&nbsp;&nbsp;
							<%
							if(i==totalpage)break;
						}
						%>
						<%
						if(usergroup!=(totalpage/pagesize-(totalpage%pagesize==0?1:0))){
							%>
							<a href="Competition.jsp?cp=<%=(usergroup+1)*pagesize+1%>">&gt;&gt;</a>
							<%
						}
						%>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>