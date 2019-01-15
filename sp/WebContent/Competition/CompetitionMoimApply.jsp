<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
#header{
	width: 600px;
	height: auto;
	margin-left: 300px;
	padding-bottom: 13px;
	border-bottom: 0.5px solid black;
}
#body{
	width: 600px;
	height: auto;
	margin-left: 300px;
	padding-bottom: 13px;
	border-bottom: 0.5px solid black;
}
.header_info{
	width: 100%;
	height: auto;
	overflow: hidden;
	position: relative;
}
.header_all{
	width: 100%;
	height: auto;
	overflow: hidden;
	position: relative;
	margin:0px;
	padding:5px;
}
.header_group{
	width: 530px;
	height: auto;
}
.header_group_people{
	width: 65px;
	height: 70px;
	padding-left: 10px;
}
.header_img{
	width: 20px;
	height: 15px;
	padding-right: 5px;
}
.bodytype_1{
	width: 600px;
	height: auto;
	margin-left: 300px;
	padding-bottom: 13px;
	border-bottom: 0.5px solid black;
}
.bodytype_2{
	width: 600px;
	height: auto;
	margin-left: 300px;
	padding-bottom: 13px;
}
</style>
</head>
<body>
<%@include file="/header.jsp"%>
<section>
	<article>
	<form name="CompetitionMoimApply" action="CompetitionMoimApply_ok.jsp">
	<div id="header">
		<h1 style="font-size:25px;margin-top:5px;">신청하려는 모임의 정보</h1>
		<fieldset>
			<legend>모임</legend>
			<h1 style="font-size:25px;text-align:center;margin:0px;">모임명</h1>
		<div class="header_info">
			<h4 style="float:left;">모임장 소개글</h4>
			<h4 style="float:right;">2019.01.13 12:20작성</h4>
		</div>
		<div class="header_all">
			<table style="width: 540px;height: auto;">
				<tr>
					<td rowspan="4"><img style="width:90px;height:100px;" src="/sp/img/profile.jpg"></td>
					<td style="font-size:19px;">홍길동</td>
					<td style="font-size:12px;color:gray;">1996년생</td>
					<td style="font-size:19px;">컴퓨터공학전공</td>
				</tr>
				<tr>	
					<td colspan="4" style="font-size:19px">안드로이드,서버</td>
				</tr>
				<tr>
					<td colspan="2"><img src="/sp/img/mail.png" class="header_img">hong@naver.com</td>
					<td><img src="/sp/img/kakao.jpg" class="header_img">dongkkk</td>
					<td><img src="/sp/img/tell.jpg" class="header_img">비공개</td>
				</tr>
			</table>
		</div>
		<h4>현재 모임에 속해있는 사람</h4>
		<table>
			<tr>
				<td><img class="header_group_people" src="/sp/img/profile.jpg"></td>
				<td>
					<ul style="margin:19px;padding:8px;">
						<li>IOS 개발,서버</li>
						<li>2명</li>
					</ul>
				</td>
				<td><img class="header_group_people" src="/sp/img/profile.jpg"></td>
				<td>
					<ul style="margin:19px;padding:8px;">
						<li>기획</li>
						<li>1명</li>
					</ul>
				</td>
			</tr>
		</table>
		<hr>
		<div class="header_group">
			<h4>이런 지역/요일에 모임을 가지고 싶어요</h4>
			<ul>
				<li>서울특별시 전체</li>
				<li>주 2회</li>
				<li>평일 1회,주말 1회</li>
			</ul>
		</div>
		</fieldset>
	</div>
	<div id="body">
		<h1 style="font-size:25px;margin-top:5px;">자기소개글 작성하기</h1>
			<table style="width:500px;height:200px;">
				<tr>
					<th>분야/전공</th>
					<td><input style="height:25px;" type="text" name="field" placeholder="DB값"></td>
				</tr>
				<tr>
					<th>출생년도</th>
					<td><input style="height:25px;" type="text" name="birthYear" placeholder="DB값"></td>
				</tr>
				<tr>
					<th>공모전 경력 여부</th>
					<td>
						<input type="radio" name="career">예
						<input type="radio" name="career">아니오
					</td>
				</tr>
			</table>
		<div style="margin-left:400px;margin-bottom:7px;">
			<input type="button" value="공모전 내역 수정하기">
		</div>
			<table border="1" style="width:550px;height:240px;">
				<tr>
					<th>공모전 이름</th>
					<td colspan="3"><input style="width:420px;height:22px;" type="text" name="cName" placeholder="DB값"></td>
				</tr>
				<tr>
					<th>공모전 기간</th>
					<td colspan="3"><input style="width:300px;height:22px;" type="text" name="period" placeholder="DB값"></td>
				</tr>
				<tr>
					<th>수상 내역</th>
					<td><input type="text" style="height:22px;" name="award" placeholder="DB값"></td>
					<th>담당 역할</th>
					<td><input type="text" style="height:22px;" name="mainRole" placeholder="DB값"></td>
				</tr>
				<tr>
					<th rowspan="3">상세 내용</th>
					<td rowspan="3" colspan="3"><textarea name="detail" cols="65" rows="6" placeholder="DB값"></textarea></td>
				</tr>
			</table>
		</div>
		<div class="bodytype_1">
			<h1 style="font-size:25px;margin:5px;">자기소개</h1>
			<textarea style="margin-top:0px;" rows="7" cols="90" placeholder="자신의 경험 or 포부 작성 이런 기술,장비를 다룰 수 있는 사람이다."></textarea>
		</div>
		<div class="bodytype_2">
			<h1 style="font-size:20px;margin:5px;">현재 또 다른 공모전이나 프로젝트에 참여하고 있으신가요?</h1>
		<div style="text-align:center;">
			<input type="radio" name="question">네
			<input type="radio" name="question">아니오
		</div>
		<div style="text-align:center;">
			<input type="button" value="지원하기">
			<input type="button" value="취소">
		</div>	
	</div>
	</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>