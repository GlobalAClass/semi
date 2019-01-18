<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
article{
	width:800px;
	margin-left: 100px;
}
.p_div{
	width: 100%;
	margin: 20px;
	padding: 10px;
	border-bottom:0.5px dotted gray;
}
.msgImg{
	width: 20px;
	padding-right: 5px;
}
.th1{
	width: 150px;
	font-size: 25px;
	text-align: left;
	padding: 10px;
}
.th2{
	width: 100px;
	font-size: 15px;
	text-align: left;
	padding: 10px;
	border-bottom: 0.5px gray dotted;
}
.td_line{
	padding: 10px;
	border-bottom: 0.5px gray dotted;
}
</style>
<script>
//미리보기 이미지를 기본으로 세팅
function setDefaultImg(){
	myProfile.proimg.src = "/sp/img/profile_default.jpg";
}
//미리보기 이미지를 선택한 그림파일로 세팅
function showImg(profile){
	//파일 읽기
	var reader = new FileReader();
	var file = profile.files[0]; //파일배열로 저장되기때문에 첫번째 파일이 현재 선택된 파일.
	if(file === undefined){ // 파일 선택을 하지 않은 경우 = 선택 파일 없음
		setDefaultImg();
	}else{ //파일 선택한 경우
		reader.readAsDataURL(file); //파일 읽기
		//파일 로드 한 후
		reader.onload = function(){
			var img = myProfile.proimg; //미리보기 이미지를 띄울 객체(img태그)
			img.src = reader.result;
		};
	}
}
//분야,전공 찾기 팝업 - 윈도우 창 기준으로 팝업 중앙에 뜨게 함.
function fieldMajorPop(){
	var popwidth = 500; //팝업창 가로 길이 설정
	var popheight = 500; //팝업창 가로 길이 설정
	//윈도우창의 크기 절반, 팝업창의 크기 절반 수치
	var popupX = (window.screen.availWidth-popwidth)/2; 
	var popupY = (window.screen.availHeight-popheight)/2; 
	window.open('fieldMajorPop.jsp', 'fieldMajorPop', 'width='+popwidth+', height='+popheight
				+',left='+popupX + ', top='+ popupY );
}
//핸드폰 번호 입력시에 4자리의 번호만 입력할 수 있도록 하기. 
function checktel(tel){
    var num_pattern = /^\d{4}$/;  // 정규표현식 사용. []안에서 ^는 '일치하지 않는'을 의미한다.
    if(!num_pattern.exec(tel.value)) { //exec는 정규표현식 패턴에 맞는 문자열 탐색
        alert("해당 항목에는 4자리의 숫자만 사용할수 있습니다.\n다른 문자는 자동적으로 제거 됩니다.");
        tel.value = tel.value.replace(/.*/g,''); //숫자를 제외한 문자열 내 모든 패턴(g=global)찾아 빈문자열로 대체.
        return false;
    }
}
//카카오id 공백,특수문자 제거 함수
function checkKakaoId(obj) {
    var space_pattern = /[\s\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/;  // 정규표현식에서 공백문자 = \s 또는 = |
    if(space_pattern.exec(obj.value)) { //공백 체크, exec는 정규표현식 패턴에 맞는 문자열 탐색
        alert("해당 항목에는 공백 및 특수문자를 사용할수 없습니다.\n자동적으로 제거 됩니다.");
        obj.value = obj.value.replace(/[\s\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g,''); //제거
        return false;
    }
}
//지역 선택시에 추가 옵션 보여주는 함수.
function addOption(obj){
	var option = obj.value; 
	var ary; 
	var addop = memberJoin.sigungu;
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
			memberJoin.sigungu.add(op);
		}
		memberJoin.sigungu.hidden=false;
	}else{
		memberJoin.sigungu.hidden=true;
	}
}
//공모전 상세이력 추가.
var addCount = 0;
function pageAdd(){
	var tb = document.getElementById('tb');
	var row = tb.insertRow(tb.rows.length);
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	cell1.innerHTML='공모전 이력 '+(addCount+1);
	cell2.innerHTML ='<table id="table_design">'
						+'<tr>'
							+'<th class="th2">공모전 이름</th>'
							+'<td class="td_line">'
							+'<input type="text"style="width: 170px; height: 20px;" name="cName'+addCount+'" required="required">'
							+'</td>'
						+'</tr>'
						+'<tr>'
							+'<th class="th2">공모전 기간</th>'
							+'<td class="td_line"><input style="width: 170px; height: 20px;" type="text" id="period'+addCount+'_1" name="period'+addCount+'_1" onchange="checkPeriod(this);" required="required" placeholder=" ex) 2018-01-01">'
							+'&nbsp;~&nbsp;'
							+'<input style="width: 170px; height: 20px;" type="text" id="period'+addCount+'_2" name="period'+addCount+'_2" onchange="checkPeriod(this);" required="required" placeholder=" ex) 2018-06-30">'
							+'<input type="text" hidden="" id="period'+addCount+'" name="period'+addCount+'" value="">'
						+'</td>'
						+'</tr>'
						+'<tr>'
							+'<th class="th2">담당역할</th>'
							+'<td class="td_line">'
							+'<select id="part" onchange="select(this)" name=mainRole'+addCount+'>'
								+'<option selected>담당 역할</option>'
								+'<option value="developer">개발자</option>'
								+'<option value="desiner">디자이너</option>'
								+'<option value="planner">기획자</option>'
								+'<option value="etc">etc</option>'
							+'</select>'
							+'<div id="roleaddCount"></div>'
							+'<input style="width: 170px; height: 20px;" type="text" id="detailRolea'+addCount+'" name="detailRole'+addCount+'">'
							+'</td>'
						+'</tr>'
						+'<tr>'
							+'<th class="th2">수상내역</th>'
							+'<td class="td_line"><input style="width: 170px; height: 20px;" type="text" placeholder="ex)입선" name="award'+addCount+'">'
						+'</td>'
						+'</tr>'
						+'<tr>'
							+'<th class="th2">상세내용</th>'
							+'<td class="td_line">'
							+'<textarea rows="12" cols="40" placeholder="필요에 따라 입력해주세요.\n어떤 활약을 펼쳤는지 간단하게 작성해주시면 도움이 됩니다." name=detail'+addCount+'></textarea>'
						+'</td>'
						+'</tr>'
					+'</table>'
	cell1.style.borderBottom="1px dotted black";
	cell1.style.textAlign="center";
	cell1.style.fontWeight="bold";
	cell2.style.borderBottom="1px dotted black";
	addCount++;
}
//공모전 상세이력 삭제.
function pageDel(){
	var tb = document.getElementById('tb');
	var row_index = tb.rows.length-1; // row 인덱스 구함.
	if(row_index > -1){ //인덱스 0이 처음에 추가된 행(상세이력)임.
		tb.deleteRow(row_index);
		addCount--;
	}
}
//공모전 상세이력 안에 역할 선택.
function select(part){
	var partname=part.value; //선택한 역할 값.
	var role = part.nextSibling; //현재 part 기준으로 다음 태그인 <div>태그 가리킴. 이 안에 세부역할 버튼들을 생성함.
	
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
	var ary; //value값들을 저장할 배열 변수 선언
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
	for(i=0; i<ary.length;i++){
		var bu =  document.createElement("input");
		bu.type = "button";
		bu.value = ary[i];
		bu.style.marginRight = "4px";
		bu.onclick = function(){role.nextSibling.value = this.value;}; //기능 : 버튼 클릭시에 버튼 값이 자동으로 text에 입력
		role.appendChild(bu);
	}
}
</script>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/mypage/aside.jsp" %>
<section>
<article>
	<form name="myProfile">
	<div align="center" style="font-size:40px;font-weight:bold;">프로필 수정하기</div>
	<div class="p_div" align="center">
	<div align="left" style="margin-botton:15px;font-size:30px;font-weight:bold;">기본 인적사항</div>
		<table style="width: 800px;">
			<tr>
				<td rowspan="3"><img name="proimg" style="margin-left:60px;width:120px;height:120px;" src="/sp/img/profile_default.jpg"></td>
				<td style="font-size:35px;font-weight: bold;">홍길동</td>
				<td style="font-size:15px;color:gray;">1996년생</td>
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
			<tr>
				<td style="width:120px;">
					<input type="file" name="picture" onchange="showImg(this);" accept=""><br>
					<span style="margin-left:8px; font-size:8px; color:#FA5882;">파일 크기 제한은 5MB입니다.</span>
				</td>
				<td colspan="4"></td>
			</tr>
		</table>
		<div align="left">
			<table>
			<tr>
				<th class="th1">분야/전공</th>
				<td colspan="3">
					<input style="width:170px;height:20px;" type="text" name="fieldMajor" readonly="readonly" required="required">
					<input type="button" value="찾기"  onclick="fieldMajorPop()">
				</td>
			</tr>
			<tr>
				<th class="th1">수신동의</th>
				<td colspan="3">이메일 수신을 허가하시겠습니까?
					<input type="radio" name="emailAgreement" value="true" required="required">예
					<input type="radio" name="emailAgreement" value="false" required="required">아니오
				</td>
			</tr>
			</table>
		</div>
	</div>
	<div class="p_div">
	<div style="margin-botton:15px;font-size:30px;font-weight:bold;">추가 인적사항</div>
	<table style="width: 800px;margin-top:20px;">
	<tr>
		<th class="th1">핸드폰번호</th>
		<td>
			<select name="headtel" style="height:30px;">
				<option>010</option>
				<option>011</option>
				<option>018</option>
			</select> -
				<input style="width:70px;height:25px;" type="text" name="tel1" maxlength="4" onchange="checktel(this);"> -
				<input style="width:70px;height:25px;" type="text" name="tel2" maxlength="4" onchange="checktel(this);">
				<input style="text" hidden="" name="contact" value="">
			핸드폰 번호 공개 동의
			<input type="radio" id="r1" name="contactAgreement" value="true"/>
    		<label for="r1"><span></span>예</label>
    		<input type="radio" id="r2" name="contactAgreement" value="false" checked="checked"/>
    		<label for="r2"><span></span>아니오</label>
    	</td>	
	</tr>
	<tr>
		<th class="th1">카카오톡ID</th>
		<td>
		<input style="width:170px;height:25px;" type="text" name="kakaoId" placeholder="내용을 입력해주세요" onkeyup="checkKakaoId(this);">
		카카오톡ID 공개 동의
			<input type="radio" id="r3" name="kakaoIdAgreement" value="true"/>
    		<label for="r3"><span></span>예</label>
    		<input type="radio" id="r4" name="kakaoIdAgreement" value="false" checked="checked"/>
    		<label for="r4"><span></span>아니오</label>
    	</td>		
	</tr>
	<tr>
		<td style="font-size:10px;color:gray;"colspan="2">연락을 받고싶은 항목에 정보를 입력해주세요. 이메일 보다 빠르게 상대방과 연락을 주고 받을 수 있습니다.</td>
	</tr>
	<tr>
		<th class="th1">출생년도</th>
		<td>
			<select name="birthYear" style="height:30px;">
				<option value="">db에서 가져온값</option>
				<%
				Calendar cal = Calendar.getInstance(); //서버시간기준으로 120세까지만 선택가능.
				int y = cal.get(Calendar.YEAR);
				for(int i=y;i>y-120;i--){
					%>
					<option value="<%=i%>"><%=i%></option>
					<%
				}
				%>
			</select>
		</td>
	</tr>
	<tr>
		<th class="th1">지역</th>
		<td>
			<select onchange="addOption(this)" name="sido"  style="height:30px;">
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
			<select hidden="" name="sigungu" style="height:30px;"> <!-- 추가옵션 달릴 부분 -->
				<option selected>선택해주세요</option>
			</select>
		</td>
	</tr>
	<tr>
		<th class="th1">공모전 이력&nbsp;</th>
		<td>
			<input type="button" value="+" onclick="pageAdd();">&nbsp;
			<input type="button" value="-" onclick="pageDel();">
		</td>
	</tr>
		<tbody id="tb">
		</tbody>
	<tr>
		<th class="th1">자기소개</th>
		<td>
			<textarea name="mProfile" onkeyup="checkLength(this);" placeholder="자신이 현재 관심있는 분야 /프로젝트를 작성해주세요." style="width:600px;height:200px;"></textarea>
			<input type="text" readonly="readonly" name="lengthinfo" style="border: none;">
		</td>	
	</tr>
	</table>
	<div align="center"><input type="submit" value="정보 수정하기" style="width:150px;height:50px;"></div>
	</div>
	</form>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>