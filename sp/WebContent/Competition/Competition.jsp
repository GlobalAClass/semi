<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
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
		<h1>전체공모전</h1>
		<table border="1">
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
				<tr>
					<td>광고</td>
					<td><a href="/sp/Competition/CompetitionDetail.jsp">부산은행 썸패스 UCC공모전</a></td>
					<td>2018.12.25 ~ 2019.01.05</td>
					<td>개인</td>
					<td>조회수</td>
				</tr>
			</tbody>
		</table>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>