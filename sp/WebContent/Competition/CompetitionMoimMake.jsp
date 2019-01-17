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
.sub{
	font-weight: bold;
}
#compInfo{
	width:800px;
	border-bottom: 0.5px dotted black;
	padding: 20px;
}
.bodytype{
	width: 800px;
	border-bottom: 0.5px dotted black;
	padding: 20px;
}
.bodytype2{
	width: 800px;
	padding-top: 20px;
	padding-left: 20px;
	padding-right: 20px;
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
</style>
<script type="text/javascript">
//지역 선택시에 추가 옵션 보여주는 함수.
function addOption(obj){
	var option = obj.value;
	var ary;
	var addop = CompetitionMoimMake.sigungu;
	//추가 옵션이 이미 있던 경우 삭제해주기. 길이를 1로 두는 것은 '선택해주세요'만 남기고 삭제하기 위해서이다.
	if(addop.length>1){
		for(i=0; i<addop.length;i++){
			addop.length=1;
		}
	}
	//선택한 지역에 따라 추가 옵션을 다르게 함.
	if(option == '서울특별시'){
		ary = ['강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', 
			'동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', 
			'용산구', '은평구', '종로구', '중구', '중랑구 '];
		
		for(var i=0; i<ary.length;i++){
			var op = new Option();
			op.value = ary[i];
			op.text = ary[i];
			CompetitionMoimMake.sigungu.add(op);
		}
		CompetitionMoimMake.sigungu.hidden=false;
	}else{
		CompetitionMoimMake.sigungu.hidden=true;
	}
}
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
//현재 팀이 존재하는지 확인 하여 세부사항 작성칸 출력 여부
//또한 팀원이 몇명 존재하는지 확인
function nowTeam(res){
	switch(res){
	case "yes":
		document.all.nowTeamMember.style.display="";
		break;
	case "no":
		document.all.nowTeamMember.style.display="none";
		break;
	}
	
}
</script>
</head>
<body>
<%@include file="/header.jsp"%>
<section>
	<article>
		<form name="CompetitionMoimMake" action="CompetitionMoimMake_ok.jsp">
		<p style="font-size: 30px; font-weight: bold;" align="center">모임을 개설하려는 공모전 정보</p>
		<div id="compInfo" align="center">
			<table style="width:800px;height:250px;">
				<tr>
					<td style="width:200px;height:250px;" rowspan="9"><img style="width:200px;height:250px;border: 1px solid gray; margin-right:30px;" src="/sp/img/content.jpg"></td>
				</tr>
				<tr>
					<td colspan="2" style="font-size:20px;">어촌 사랑 초등학생 공모전</td>
				</tr>
				<tr>
					<td class="sub">분야</td>
					<td>디자인</td>
				</tr>
				<tr>
					<td class="sub">팀/개인</td>
					<td>개인</td>
				</tr>
				<tr>
					<td class="sub">주최</td>
					<td>고용노동부</td>
				</tr>
				<tr>
					<td class="sub">주관</td>
					<td>방송통신위원회, 안전보건공단</td>
				</tr>
				<tr>
					<td class="sub">참가자격</td>
					<td>초등학생</td>
				</tr>
				<tr>
					<td class="sub">접수기간</td>
					<td>2018-12-21 ~ 2019-01-30</td>
				</tr>
				<tr>
					<td class="sub">홈페이지</td>
					<td><a>홈페이지 링크 걸기</a></td>
				</tr>
			</table>
		</div>
		<div class="bodytype2">
			<p style="font-size:25px; font-weight: bold;">모임명
			<input style="margin-left:20px;width: 300px;height:25px;" type="text" name="matchName" placeholder=" 작성하지 않으면 랜덤으로 설정됩니다." required="required">
			</p>
			<p style="text-align:left;font-size:25px; font-weight: bold;">모임 개설자 소개</p>
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
		<div class="bodytype">
			<div style="font-size:25px;font-weight: bold;margin-bottom:15px;">현재 구성된 팀원</div>
			<div>현재 구성된 팀원이 존재합니까?
				<input type="radio" name="team" value="yes" onchange="nowTeam(this.value)">예
				<input type="radio" name="team" value="no" onchange="nowTeam(this.value)" checked>아니오
			</div>
			<div id="nowTeamMember" style="display: none;">
			<p>현재 존재하는 팀원수(본인포함)
			<select onchange="nowTeam(this.value)">
				<option value="2" selected>2명</option>
				<option value="3">3명</option>
				<option value="4">4명</option>
				<option value="5">5명</option>
			</select>
			</p>
			<div id="tRole">
			팀원의 역할을 간단하게 소개해주세요
			</div>
			</div>
		</div>
		<div class="bodytype">
			<div style="font-size:25px;font-weight: bold;">이런 지역/요일에 모임을 가지고 싶어요</div>
			<p>지역 선택
			<select onchange="addOption(this)" name="sido" style="width:130px;height:25px;">
				<option selected>선택해주세요</option>
				<option>서울특별시</option>
				<option>인천광역시</option>
				<option>대구광역시</option>
				<option>부산광역시</option>
				<option>광주광역시</option>
				<option>대전광역시</option>
				<option>울산광역시</option>
				<option>세종시</option>
				<option>경기도</option>
				<option>강원도</option>
				<option>충청남도</option>
				<option>충청북도</option>
				<option>경상북도</option>
				<option>경상남도</option>
				<option>전라북도</option>
				<option>전라남도</option>
				<option>제주도</option>
			</select>
			<select hidden="" name="sigungu" style="width:130px;height:25px;"> <!-- 추가옵션 달릴 부분 -->
				<option selected>선택해주세요</option>
			</select>
			</p>
			주
			<select style="width:45px;height:25px;">
				<option value="1회" selected>1회</option>
				<option value="2회">2회</option>
				<option value="3회">3회 이상</option>
			</select>
			<input style="width:230px;height:22px;" type="text" name="timesAWeek" placeholder="가능한 요일/시간대 작성" required="required">
		</div>
		<div class="bodytype">
			<div style="font-size:25px;font-weight: bold;margin-right: 40px;">이런 사람을 구하고 있어요</div>
			<p>나이 제한
			<input style="width:45px;height:25px;" type="text" name="ageRestriction">
			<input style="width:20px;height:20px;" type="checkbox" value="나이 무관">나이 무관</p>
			구하고 싶은 팀원 수
			<select style="width:45px;height:25px;">
				<option>1명</option>
				<option>2명</option>
				<option>3명</option>
				<option>4명</option>
			</select>
		</div>
		<div class="bodytype">
			<div style="margin-top:15px;margin-bottom:15px;"><font style="font-size:25px;font-weight:bold;margin-right:300px;">이런 기술/장비를 다뤄보고 싶어요</font>
			<input style="width:20px;height:20px;" type="checkbox" value="추후 지정">추후 지정</div>
			<textarea style="width:800px; height: 150px;" placeholder="공모전에서 다루고 싶은 기술/장비 관련 세부사항이 있다면 작성해주세요."></textarea>
		</div>
		<div class="bodytype2">
			<div style="font-size:25px;font-weight:bold;margin-bottom:15px;">공모전 모임 상세 소개</div>
			<textarea style="width:800px; height: 150px;" placeholder="소개하고 싶은 공모전 모임 관련 세부사항을 작성해주세요."></textarea>
		</div>
		<div style="text-align:center;">
				<input class="btn" type="submit" value="모임 만들기">
				<input class="btn" type="button" value="취소">
		</div>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>