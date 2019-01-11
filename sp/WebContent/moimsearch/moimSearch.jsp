<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
</style>
<script>
function select(){
	var partname=document.all.part.value;
	document.all.developer.style.display="none";
	document.all.desiner.style.display="none";
	document.all.planner.style.display="none";
	document.all.etc.style.display="none";
	switch(partname){
	case "developer":
		document.all.developer.style.display="";
		break;
	case "desiner":
		document.all.desiner.style.display="";
		break;
	case "planner":
		document.all.planner.style.display="";
		break;
	case "etc":
		document.all.etc.style.display="";
		break;
	}
}
</script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
		<div>
			<select>
				<option selected>지역</option>
				<option value="서울특별시">서울특별시</option>
				<option value="인천광역시">인천광역시</option>
				<option value="대구광역시">대구광역시</option>
				<option value="부산광역시">부산광역시</option>
				<option value="광주광역시">광주광역시</option>
				<option value="대전광역시">대전광역시</option>
				<option value="울산광역시">울산광역시</option>
				<option value="세종시">세종시</option>
				<option value="경기도">경기도</option>
				<option value="강원도">강원도</option>
				<option value="충청남도">충청남도</option>
				<option value="충청북도">충청북도</option>
				<option value="경상북도">경상북도</option>
				<option value="경상남도">경상남도</option>
				<option value="전라북도">전라북도</option>
				<option value="전라남도">전라남도</option>
				<option value="제주도">제주도</option>
			</select>
			<select>
				<option selected>공모전</option>
				<option>광고/마케팅</option>
				<option>기획/아이디어</option>
				<option>디자인</option>
				<option>UCC/영상</option>
				<option>과학/공학/IT</option>
				<option>그 외 공모전</option>
			</select>
			<select id="part" onchange="select()">
				<option selected>담당 역할</option>
				<option value="developer">개발자</option>
				<option value="desiner">디자이너</option>
				<option value="planner">기획자</option>
				<option value="etc">etc</option>
			</select>
			</div>
			<div>
			<form id="developer" style="display: none;">
				<input type="button" value="서버">
				<input type="button" value="DB">
				<input type="button" value="블록체인">
				<input type="button" value="클라우드">
				<input type="button" value="빅데이터">
				<input type="button" value="데이터 분석">
				<input type="button" value="IOS">
				<input type="button" value="안드로이드">
				<input type="button" value="WEB">
			</form>
			<form id="desiner" style="display: none;">
				<input type="button" value="UI/UX디자인">
				<input type="button" value="일러스트">
				<input type="button" value="에프터이펙트">
				<input type="button" value="포토샵">
				<input type="button" value="3D MAX">
				<input type="button" value="웹툰">
				<input type="button" value="프로토타이핑 툴">
				<input type="button" value="BI디자인">
			</form>
			<form id="planner" style="display: none;">
				<input type="button" value="기획">
				<input type="button" value="마케팅">
				<input type="button" value="컨텐츠 제작">
				<input type="button" value="SNS">
				<input type="button" value="온라인 마케팅">
			</form>
			<form id="etc" style="display: none;">
				<input type="button" value="영상 제작">
				<input type="button" value="영상 촬영">
				<input type="button" value="영상 편집">
				<input type="button" value="통계 분석">
				<input type="button" value="아이디어">
			</form>
			</div>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>