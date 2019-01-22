<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="member.*" %>

<jsp:useBean id="mhdto" class="member.MemberHistoryDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mhdto"/>

<%
	//cname만 항상 null이 찍혀서 따로 받음.
	String cname = request.getParameter("cName");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.competition_table {
	margin-top: 30px;
	margin-left: 100px;
	width: 800px;
	border: gray solid 0.5px;
	padding: 2px;
	border-collapse: collapse;
	border-spacing: 0;
}
.competition_table th{
	background: #E6E6E6;
	width: 150px;
	height: 50px;
	font-size: 20px;
}
.competition_table td{
	padding-left: 10px;
}
</style>
</head>
<body>
	<table border="1" class="competition_table">
		<tr>
			<th>공모전 이름</th>
			<td><%=cname %></td>
		</tr>
		<tr>
			<th>공모전 기간</th>
			<td><%=mhdto.getPeriod() %></td>
		</tr>
		<tr>
			<th>담당 역할</th>
			<td><%=mhdto.getMainRole() %> - <%=mhdto.getDetailRole() %></td>
		</tr>
		<tr>
			<th>수상 내역</th>
			<td><%=mhdto.getAward() %></td>
		</tr>
		<tr>
			<th>상세 내용</th>
			<td><%=mhdto.getDetail() %></td>
		</tr>
	</table>
</body>
</html>