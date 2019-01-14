<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#group_name{
	width:100%;
	height:auto;
	text-align:center;
}
.group_info{
	width: 100%;
	height: auto;
	overflow: hidden;
	position: relative;
}
.group_all{
	width: 100%;
	height: auto;
	overflow: hidden;
	position: relative;
	margin:0px;
	padding:5px;
}
.group_2 th{
	background: #D8D8D8;
}
.group{
	width: 530px;
	height: auto;
	border-bottom: 1px solid black;
}
.group_people{
	width: 65px;
	height: 70px;
	padding-left: 10px;
}
.group_img{
	width: 20px;
	height: 15px;
	padding-right: 5px;
}
</style>
	<div id="group_name">
	<h2>모임명</h2>
	</div>
	<div class="group_info">
		<h4>모임장 소개글</h4>
		<h4>2019.01.13 12:20작성</h4>
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
				<td></td>
			</tr>
			<tr>
				<th>공모전 기간</th>
				<td></td>
			</tr>
			<tr>
				<th>담당 역할</th>
				<td></td>
			</tr>
			<tr>
				<th>수상 내역</th>
				<td></td>
			</tr>
			<tr>
				<th>상세 내용</th>
				<td></td>
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