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
	width:100%;
	height: 350px;
	text-align: center;
	border-bottom: 0.5px solid black;
}
.header_img{
	float: left;
	border: 1px solid #D8D8D8;
	margin-top: 5px;
	margin-left: 400px;
}
.bodytype_1{
	width: 100%;
	height: 550px;
	border-bottom: 0.5px solid black;
	margin-top:10px;
}
.bodytype_2{
	width: 100%;
	height: 400px;
	border-bottom: 0.5px solid black;
	margin-top:10px;
	text-align:center;
}
.bodytype_3{
	width: 100%;
	height: 170px;
	border-bottom: 0.5px solid black;
	margin-top:10px;
	text-align:center;
}
.bodytype_4{
	width: 100%;
	height: 250px;
	margin-top:10px;
	margin-top:10px;
	text-align:center;
}
</style>
</head>
<body>
<%@include file="/header.jsp"%>
<section>
	<article>
		<form name="CompetitionMoimMake" action="CompetitionMoimMake_ok.jsp">
		<div id="header">
			<h1 style="font-size:25px;margin-top:5px;">모임을 개설하려는 공모전 정보</h1>
			<div class="header_img">
				<img style="width:200px;height:250px;" src="/sp/img/content.jpg">
			</div>
			<table style="text-align:left;float:left;margin-top:5px;margin-left:10px;">
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
		<div class="bodytype_1">
			<h1 style="text-align:center;font-size:25px;margin-top:5px;">모임 개설자 소개</h1>
			<table align="center" style="width:500px;height:200px;">
				<tr>
					<th>모임명</th>
					<td><input style="width:300px;height:25px;" type="text" name="matchName" placeholder="작성하지 않으면 랜덤으로 설정됩니다." required="required"></td>
				</tr>
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
			<div style="text-align:center;margin-left:400px;margin-bottom:7px;">
				<input type="button" value="공모전 내역 수정하기">
			</div>
			<table align="center" border="1" style="width:550px;height:240px;">
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
		<div class="bodytype_2">
			<h1 style="font-size:25px;margin-top:5px;">현재 구성된 팀원</h1>
			현재 구성된 팀원이 존재합니까?
			<input type="radio" name="team">예
			<input type="radio" name="team">아니오<br><br>
			현재 존재하는 팀원수(본인포함)
			<select>
				<option value="1명" selected>1명</option>
				<option value="2명">2명</option>
				<option value="3명">3명</option>
				<option value="4명">4명</option>
			</select><br><br>
			팀원의 역할을 간단하게 소개해주세요
		</div>
		<div class="bodytype_3">
			<h1 style="font-size:25px;margin-top:5px;">이런 지역/요일에 모임을 가지고 싶어요</h1>
			지역 선택
			<select>
				<option>대분류</option>
			</select>
			<select>
				<option>소분류</option>
			</select><br><br>
			주
			<select>
				<option value="1회" selected>1회</option>
				<option value="2회">2회</option>
				<option value="3회">3회</option>
				<option value="4회">4회</option>
			</select>
			<input style="width:230px;height:22px;" type="text" name="timesAWeek" placeholder="가능한 요일/시간대 작성" required="required">
		</div>
		<div class="bodytype_2">
			<h1 style="font-size:25px;margin-top:5px;">이런 사람을 구하고 있어요</h1>
			나이 제한
			<input style="width:45px;height:22px;" type="text" name="ageRestriction">
			<input type="checkbox" value="나이 무관">나이 무관<br><br>
			구하고 싶은 팀원 수
			<select>
				<option>1명</option>
				<option>2명</option>
				<option>3명</option>
				<option>4명</option>
			</select>
		</div>
		<div class="bodytype_3">
			<font style="font-size:25px;font-weight:bold;margin-top:5px;">이런 기술/장비를 다뤄보고 싶어요</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="checkbox" value="추후 지정">추후 지정<br><br>
			<textarea rows="7" cols="80" placeholder="공모전에서 다루고 싶은 기술/장비 관련 세부사항이 있다면 작성해주세요."></textarea>
		</div>
		<div class="bodytype_4">
			<h1 style="font-size:25px;margin-top:5px;">공모전 모임 상세 소개</h1>
			<textarea rows="7" cols="80" placeholder="소개하고 싶은 공모전 모임 관련 세부사항을 작성해주세요."></textarea><br><br><br>
			<div style="text-align:center;">
				<input type="submit" value="모임 만들기">
				<input type="button" value="취소">
			</div>
		</div>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>