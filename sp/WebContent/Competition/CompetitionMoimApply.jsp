<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
article{
	width:800px;
	margin-left:200px;
}
.bodytype2{
	width: 800px;
	padding-top: 20px;
	padding-left: 20px;
	padding-right: 20px;
}
.bodytype{
	width: 800px;
	border-bottom: 0.5px solid black;
	padding: 20px;
}
.btn{
	width: 150px;
	height: 50px;
	font-size: 20px;
	margin: 20px;
}
#pfimg{
	width:80px;
	height:80px;
	padding:2px;
}
#header{
	width: 600px;
	padding: 10px;
	border: 0.5px dotted gray;
}

.header_info{
	width: 100%;
	overflow: hidden;
	position: relative;
}
.header_all{
	width: 100%;
	overflow: hidden;
	position: relative;
	margin:0px;
	padding:5px;
}
.header_group_people{
	width: 60px;
	height: 60px;
	padding-left: 10px;
}
.msgImg{
	width: 20px;
	padding-right: 5px;
}
ul{
	list-style: none;
}
</style>
<script type="text/javascript">
function select(part){
	var partname=part.value; //선택한 역할 값.
	var role = document.getElementById("role"); //현재 part 기준으로 다음 태그인 <div>태그 가리킴. 이 안에 세부역할 버튼들을 생성함.
	
	//담당역할 선택 -> 세부사항 기입 불가, 세부사항 빈문자열.
	if(partname=="담당 역할"){
		role.nextSibling.value = ''; //<div>태그의 다음 태그이므로 세부사항을 입력하는 <input>태그를 가리킴.
		role.nextSibling.readOnly=true;
	}else{
		role.nextSibling.readOnly=false;
	}
	//div안에 있는 버튼 삭제
	while(role.firstChild) {
	  role.removeChild(role.firstChild);
	}
	//버튼에 사용할 value값들
	var ary=0; //value값들을 저장할 배열 변수 선언
	switch(partname){
	case "developer":
		ary = ['개발자','서버','DB','블록체인','클라우드','빅데이터','데이터 분석','IOS','안드로이드','WEB'];
		break;
	case "desiner":
		ary = ['UI/UX디자인','일러스트','에프터이펙트','포토샵','3D MAX','웹툰프로토타이핑 툴','BI디자인'];
		break;
	case "planner":
		ary = ['기획','마케팅','컨텐츠 제작','SNS','온라인 마케팅'];
		break;
	case "etc": //나중에 추가할 세부역할들.
		ary = ['영상 제작',	'영상 촬영','영상 편집','통계 분석','아이디어'];
		break;
	}
	
	//버튼 추가
	for(var i=0; i<ary.length;i++){
		var bu =  document.createElement("INPUT");
		bu.type = "button";
		bu.value = ary[i];
		bu.style.marginRight = "4px";
		bu.onclick = function(){document.getElementById("detailRole").value = this.value;}; //기능 : 버튼 클릭시에 버튼 값이 자동으로 text에 입력
		
		role.appendChild(bu);
	}
}

//submit 전에 유효성 검사
//function formCheck(){
//	if(CompetitionMoimApply.apply ==""){
//		alert("")
//		CompetitionMoimApply.fieldMajor.focus();
//		return false;
//		return false;
//	}else{
//		return true;
//	}
//}
</script>
</head>
<body>
<%@include file="/header.jsp"%>
<section>
	<article>
	<form name="CompetitionMoimApply" action="CompetitionMoimApply_ok.jsp" onsubmit="return formCheck()">
	<div class="bodytype" align="center">
	<div style="font-size:30px;font-weight: bold;margin-bottom:10px;">신청하려는 모임의 정보</div>
	<div id="header">
	<h2 style="font-size:20px;margin:0px;">모임장 소개</h2>
		<div class="header_all" align="center">
			<table style="width: 540px;height: auto;">
				<tr>
					<td rowspan="4"><img style="width:100px;height:100px;" src="/sp/img/profile.jpg"></td>
					<td style="font-size:25px;font-weight: bold;">홍길동</td>
					<td style="font-size:12px;color:gray;">1996년생</td>
					<td colspan="2" style="font-size:16px;">컴퓨터공학전공</td>
				</tr>
				<tr>	
					<td colspan="4" style="font-size:16px">안드로이드</td>
				</tr>
				<tr>
					<td colspan="2"><img src="/sp/img/mail.png" class="msgImg">hong@naver.com</td>
					<td><img src="/sp/img/kakao.jpg" class="msgImg">dongkkk</td>
					<td><img src="/sp/img/tell.jpg" class="msgImg">비공개</td>
				</tr>
			</table>
		</div>
		<h4 style="font-size:20px;">현재 모임에 속해있는 사람</h4>
		<table>
			<tr>
				<td><img class="header_group_people" src="/sp/img/profile.jpg"></td>
				<td>
					<ul style="padding:8px;">
						<li><b>IOS</b></li>
						<li>2명</li>
					</ul>
				</td>
				<td><img class="header_group_people" src="/sp/img/profile.jpg"></td>
				<td>
					<ul style="padding:8px;">
						<li><b>기획</b></li>
						<li>1명</li>
					</ul>
				</td>
			</tr>
		</table>
		<div>
			<h4 style="font-size:20px;">이런 지역/요일에 모임을 가지고 싶어요</h4>
			<ul>
				<li style="font-size:17px;color:darkblue;">서울특별시 전체</li>
				<li style="font-size:15px;color:darkgreen;">주 2회</li>
				<li style="font-size:15px;color:darkgreen;">평일 1회,주말 1회</li>
			</ul>
		</div>
	</div>
	</div>
			<div class="bodytype2">
			<div style="font-size:25px; font-weight: bold;">자기소개서 작성</div>
			<table style="width:800px;height:200px;text-align:left;">
				<tr>
					<td rowspan="4" style="width:100px"><img src="/sp/img/profile.jpg" id="pfimg">
					<input style="width:90px; font-size:11px;" type="button" value="사진 수정하기">
					</td>
					<th style="width:150px;height:80px;">담당 역할</th>
					<td>
					<select id="part" onchange="select(this)" style="width:130px;height:25px;">
						<option selected>선택하기</option>
						<option value="developer">개발자</option>
						<option value="desiner">디자이너</option>
						<option value="planner">기획자</option>
						<option value="etc">etc</option>
					</select>
					<input style="width:170px;height:20px;" type="text" id="detailRole" name="detailRole">
					<div style="font-size:11px; color:#D20505;">해당 담당 역할이 없는경우 직접 작성해주세요. (1개 선택 가능)</div>
					<div id="role"></div>
					</td>
				</tr>
				<tr>
					<th>분야/전공</th>
					<td><input style="height:25px;" type="text" name="field" readonly="readonly" placeholder="DB값"></td>
				</tr>
				<tr>
					
					<th>출생년도</th>
					<td><input style="height:25px;" type="text" name="birthYear" readonly="readonly" placeholder="DB값"></td>
				</tr>
				<tr>
					
					<th>공모전 경력 여부</th>
					<td>
						<input type="radio" name="career">예
						<input type="radio" name="career" checked>아니오
					</td>
				</tr>
			</table>
		</div>
		<div class="bodytype" align="center">
			<p style="text-align:right;">
				<input type="button" value="공모전 내역 수정하기">
			</p>
			<table border="1" cellspacing="0" style="width:700px;height:240px;">
				<tr>
					<th style="width:150px;height:25px;">공모전 이름</th>
					<td style="width:550px;height:25px;" colspan="3">db값</td>
				</tr>
				<tr>
					<th>공모전 기간</th>
					<td style="width:550px;height:25px;" colspan="3">db</td>
				</tr>
				<tr>
					<th>수상 내역</th>
					<td>db</td>
					<th style="width:150px;height:25px;">담당 역할</th>
					<td>db</td>
				</tr>
				<tr>
					<th rowspan="3">상세 내용</th>
					<td rowspan="3" colspan="3"><pre>상세내용 블랍ㄹ라ㅏㅏ..</pre></td>
				</tr>
			</table>
		</div>
		<div class="bodytype2">
			<div style="font-size:25px;font-weight:bold;margin-bottom:15px;">자기소개</div>
			<textarea id="applyProfile" style="width:800px; height: 150px;" placeholder="프로젝트 경험 또는 다룰 수 있는 기술에 대해 설명해주세요."></textarea>
		</div>
		<div class="bodytype2" align="center">
			<div style="font-size:25px;font-weight: bold;">현재 또 다른 공모전이나 프로젝트에 참여하고 있으신가요?</div>
		<p>
			<input type="radio" name="question" value="예. 참여하고 있습니다.">네
			<input type="radio" name="question" value="아니오. 참여하고 있지 않습니다.">아니오
		</p>
		<div style="text-align:center;">
			<input class="btn" type="button" value="모임 지원하기">
			<input class="btn" type="button" value="취소">
		</div>	
	</div>
	</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>