<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="competition.*" %>
<jsp:useBean id="cdto" class="competition.CompetitionInfoDTO"/>
<jsp:setProperty property="*" name="cdto"/>
<jsp:useBean id="cdao" class="competition.CompetitionInfoDAO"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<%
String field=request.getParameter("field");

int totalcnt=cdao.getTotalCnt2(field);
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
ArrayList<CompetitionInfoDTO> arr=cdao.CompetitionFieldList(field,cp,listsize);
%>
<style>
#main{
	float:left;
	width:1000px;
	height:auto;
}
h1{
	font-size: 30px;
	text-align: center;
	margin: 0px;
	padding: 9px;
}
</style>
</head>
<body>
<%@include file="/header.jsp"%>
<%@include file="/Competition/aside.jsp"%>
<section>
	<article>
		<form name="Competition">
		<div id="main">
		<h1><%=field%></h1>
			<table style="width:650px;height:auto;margin-left:190px;" border="1">
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
								<td><%=arr.get(i).getField()%></td>
								<td><a href="CompetitionDetail.jsp?ix=<%=arr.get(i).getCompetitionInfoIx()%>"><%=arr.get(i).getCName()%></a></td>
								<td><%=arr.get(i).getPeriod()%></td>
								<td><%=arr.get(i).getTeamSolo()%></td>
								<td><%=arr.get(i).getReadnum()%></td>
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
							<a href="CompetitionField.jsp?cp=<%=(usergroup-1)*pagesize+pagesize%>&field=<%=field%>">&lt;&lt;</a>
							<%
						}
						%>
						<%
						for(int i=usergroup*pagesize+1;i<usergroup*pagesize+pagesize;i++){
							%>
							&nbsp;&nbsp;<a href="CompetitionField.jsp?cp=<%=i%>&field=<%=field%>"><%=i%></a>&nbsp;&nbsp;
							<%
							if(i==totalpage)break;
						}
						%>
						<%
						if(usergroup!=(totalpage/pagesize-(totalpage%pagesize==0?1:0))){
							%>
							<a href="CompetitionField.jsp?cp=<%=(usergroup+1)*pagesize+1%>&field=<%=field%>">&gt;&gt;</a>
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