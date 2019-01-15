<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="competition.*"%>
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
h1{
	font-size: 30px;
	text-align: center;
	margin: 0px;
	padding: 9px;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/Competition/aside.jsp" %>
<section>
	<article>
		<form name="Competition" action="Competition_ok.jsp">
		<div id="main">
		<h1>전체공모전</h1>
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
				ArrayList<CompetitionInfoDTO> arr=cdao.CompetitionAllList();
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
							<td><%=arr.get(i).getCName()%></td>
							<td><%=arr.get(i).getPeriod()%></td>
							<td><%=arr.get(i).getTeamSolo()%></td>
							<td><%=arr.get(i).getReadnum()%></td>
						</tr>
						<%
					}
				}
				%>
				</tbody>
			</table>
		</div>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>