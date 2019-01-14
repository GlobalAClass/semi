<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
.img_type{
	float: left;
	border: 1px solid #D8D8D8;
	margin-top: 30px;
	margin-left: 50px;
}
.Competition_info{
	float: left;
	margin-top: 30px;
	margin-left: 10px;
}
.Competition_title{
	width: 430px;
	float: left;
	margin-top: 10px;
	margin-left: 50px;
	background: #D8D8D8;
	color: black;
	font-size: 20px;
	font-weight: bold;
}
.Competition_title h1{
	margin-left: 21px;
}
.Create_group{
	text-align: right;
	float: right;
}
.Competition_namecard{
	width: 420px;
	float: left;
	margin-top: 10px;
	margin-left: 55px;
}
.Competition_namecard p{
	float: right;
	margin-top: 0px;
}
.Competition_namecard table{
	float: right;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/aside.jsp" %>
<section>
	<article>
		<div class="img_type">
			<img style="width:200px;height:250px;" src="/sp/img/content.jpg">
		</div>
		<div class="Competition_info">
			<table>
				<tr>
					<td>어촌사랑 초등학생 공모전</td>
				</tr>
				<tr>
					<td>분야</td>
				</tr>
				<tr>
					<td>팀/개인</td>
				</tr>
				<tr>
					<td>주최</td>
				</tr>
				<tr>
					<td>주관</td>
				</tr>
				<tr>
					<td>참가자격</td>
				</tr>
				<tr>
					<td>접수기간</td>
				</tr>
				<tr>
					<td>홈페이지</td>
				</tr>
			</table>
		</div>	
		<div class="Competition_title">
			<h1>현재 생성된 모임&nbsp;&nbsp;|&nbsp;&nbsp;공모전 상세보기</h1>
		</div>
		<div class="Create_group">
			<input type="button" value="모임생성하기">
		</div>
		<a href="/sp/Competition/Competition_name.jsp">
		<div class="Competition_namecard">
			<fieldset>
			<legend>공모전</legend>
			<img style="width:50px;height:100px;" src="/sp/img/프로필.png">
			<p>글 작성일</p>
			<table>
				<tr>
					<th>공모전명</th>
				</tr>
				<tr>
					<td>모임명|모임 주최자</td>
				</tr>
				<tr>
					<td>현재인원/총 인원&nbsp;&nbsp;&nbsp;1/5</td>
				</tr>
				<tr>
					<td>모집 인원&nbsp;&nbsp;&nbsp;개발자 2명/디자이너1명</td>
				</tr>
			</table>
			</fieldset>
		</div>
		</a>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>