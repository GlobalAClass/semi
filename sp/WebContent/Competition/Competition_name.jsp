<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
section{
	width: 520px;
	height: auto;
	float: left;
	overflow: hidden;
	position: relative;
}
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
.group_name{
	width:100%;
	height:auto;
	text-align:center;
	float: left;
}
.group_info{
	width: 100%;
	height: auto;
	overflow: hidden;
	position: relative;
	float: left;
	margin-top:0px;
	padding-top: 0px;
}
.group_all{
	width: 100%;
	height: auto;
	overflow: hidden;
	position: relative;
	float: left;
	margin:0px;
	padding:5px;
}
.group_2 th{
	background: #D8D8D8;
}
.group{
	width: 530px;
	height: auto;
	float: left;
	border-bottom: 1px solid black;
}
.group_people{
	width: 65px;
	height: 70px;
	float: left;
	padding-left: 10px;
}
.group_img{
	width: 20px;
	height: 15px;
	padding-right: 5px;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/aside.jsp" %>
<section>
	<article>
		<form name="Competition" action="/sp/Competition/Competition_name_ok.jsp">
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
			<h1 style="margin-left:21px;">현재 생성된 모임&nbsp;&nbsp;|&nbsp;&nbsp;공모전 상세보기</h1>
		</div>
			<a href="Competition_title.jsp"><input style="width:160px;height:30px;float:left;margin-top:10px;" type="button" value="모임 목록으로 돌아가기"></a>
			<input style="width:100px;height:30px;float:right;background:#58ACFA;color:white;margin-top:10px;" type="button" value="글 수정하기">
		<div class="group_name">
			<h2>모임명</h2>
		</div>
		<div class="group_info">
			<h4 style="float:left;">모임장 소개글</h4>
			<h4 style="float:right;font-size:12px;">2019.01.13 12:20작성</h4>
		</div>
		<div class="group_all">
			<table style="width: 540px;height: auto;">
				<tr>
					<td rowspan="4"><img style="width:90px;height:100px;" src="/sp/img/profile.jpg"></td>
					<td style="font-size:19px;">홍길동</td>
					<td style="font-size:12px;color:gray;">1996년생</td>
					<td>컴퓨터공학전공</td>
				</tr>
				<tr>	
					<td colspan="4" style="font-size:19px">안드로이드,서버</td>
				</tr>
				<tr>
					<td colspan="2"><img src="/sp/img/mail.png" class="group_img">hong@naver.com</td>
					<td><img src="/sp/img/kakao.jpg" class="group_img">dongkkk</td>
					<td><img src="/sp/img/tell.jpg" class="group_img">비공개</td>
				</tr>
				<tr>		
					<td>공모전 경력</td>
					<td colspan="2" style="color:green;font-size:15px;">있음</td>
					<td style="color:red;">세부사항 닫기</td>
				</tr>
			</table>
			<table border="1" class="group_2">
				<tr>
					<th>공모전 이름</th>
					<td><input size="55" type="text" name="Competition_name"></td>
				</tr>
				<tr>
					<th>공모전 기간</th>
					<td><input size="55" type="text" name="Competition_day"></td>
				</tr>
				<tr>
					<th>담당 역할</th>
					<td><input size="55" type="text" name="Competition_role"></td>
				</tr>
				<tr>
					<th>수상 내역</th>
					<td><input size="55" type="text" name="Competition_award"></td>
				</tr>
				<tr>
					<th>상세 내용</th>
					<td><input size="55" type="text" name="Competition_info"></td>
				</tr>
			</table>
		<div class="group">
			<h4>현재 모임에 속해있는 사람</h4>
			<img class="group_people" src="/sp/img/profile.jpg">
			<ul style="float:left;">
				<li>WEB</li>
				<li>1명</li>
			</ul>
			<img class="group_people" style="margin-left:60px;" src="/sp/img/profile.jpg">
			<ul style="float:left;">
				<li>포토샵,UI/UX디자인</li>
				<li>1명</li>
			</ul>
		</div>
		<div class="group">
			<h4>이런 지역/요일에 모임을 가지고 싶어요</h4>
			<ul>
				<li>서울특별시 전체</li>
				<li>주 2회</li>
				<li>평일 1회,주말 1회</li>
			</ul>
		</div>
		<div class="group">
			<h4>이런 기술/장비를 이용하고 싶어요</h4>
			<ul>
				<li>기술 블라블라</li>
				<li>장비 블라블라</li>
			</ul>
		</div>
		<div class="group">
			<h4>공모전 모임 상세소개</h4>
			<h5>안녕하세요 저희 공모전 공모전에 오신걸 환영합니다. 블라브랍라르라라아아아</h5>
		</div>
		<div class="group">
			<h4>이런 사람을 구하고 있어요</h4>
			<table>
				<tr>
					<td><img class="group_people" src="/sp/img/profile.jpg"></td>
					<td>
						<ul style="margin:19px;padding:0px;">
							<li>IOS 개발,서버</li>
							<li>2명</li>
						</ul>
					</td>
					<td><input style="width:70px;height:40px;background:#58ACFA;color:white;" type="button" value="지원하기"></td>
					<td><img class="group_people" src="/sp/img/profile.jpg"></td>
					<td>
						<ul  style="margin:19px;padding:0px;">
							<li>기획</li>
							<li>1명</li>
						</ul>
					</td>
					<td><input style="width:70px;height:40px;background:#58ACFA;color:white;" type="button" value="지원하기"></td>
				</tr>
			</table>
		</div>
		</div>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>