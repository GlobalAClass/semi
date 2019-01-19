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
									<td><%=arr.get(i).getField()%></td>
									<td style="width:300px;"><a href="/sp/Competition/CompetitionDetail.jsp?ix=<%=arr.get(i).getCompetitionInfoIx()%>"><%=arr.get(i).getCName()%></a></td>
									<td><%=arr.get(i).getReadnum()%></td>
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
		</div>
	</article>
<%@include file="/footer.jsp" %>
</section>
</body>
</html>