<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="member.MemberDTO" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="java.util.Date" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="mdto" class="member.MemberDTO"/>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="member.MemberDAO" scope="session"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
h1{
	text-align: center;
	font-size: 30px;
	margin-top: 4px;
}
#memberinput{
	border-top: 1px solid black;
	background: #BDBDBD;
	color: white;
	font-size: 18px;
	font-weight: bold;
	padding: 5px;
}
#table_design{
	width:100%;
	height:180px;
}
#table_design2{
	width:100%;
	height: 320px;
}
#design{
	border-bottom: 1px dotted black;
}
#join{
	background: #424242;;
	color: white;
	font-size: 18px;
	font-weight: bold;
}
.height_170px{
	height: 170px;
}
.height_50px{
	height: 50px;
}
input[type="radio"] {
    display:none;
}

input[type="radio"] + label {
    color:black;
    margin-left: 5px;
}

input[type="radio"] + label span {
    display:inline-block;
    width:19px;
    height:19px;
    margin:-2px 10px 0 0;
    vertical-align:middle;
    background:url(/sp/img/check_radio_sheet.png)  -39px top no-repeat;
    cursor:pointer;
}

input[type="radio"]:checked + label span {
    background:url(/sp/img/check_radio_sheet.png) -58px top no-repeat;
}
</style>
</head>
<script type="text/javascript">
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
function checkLength(obj){
	var textvalue = new String(obj.value); // 자기소개의 입력된 문자열
	var tcount = 0; //자기소개의 입력된 값의 길이를 구할 변수

	for(i=0;i<textvalue.length;i++){
		var tchar = textvalue.charAt(i);
		var addlen = escape(tchar).length > 4? 3:1; //오라클 DB에서 한글은 3, 영어는 1이므로
		tcount += addlen;
		
		//varchar2(3000)으로 자기소개를 제한해두었기 때문에 아래와 같이 제한을 주기.
		if(tcount > 2990){
			alert('입력제한 길이를 초과하였습니다.');
			obj.value = textvalue.substr(0,i-1); //제한 길이를 넘길수 없게 textarea값 조정.
			tcount -=addlen; //조정한 길이 반영.
			break;
		}
	}
	
	memberJoin.lengthinfo.value= tcount+'/2990bytes';
}

//공모전 상세이력 추가.
var addCount = 0;
function pageAdd(){
	var tb = document.getElementById('tb');
	var row = tb.insertRow(tb.rows.length);
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	cell1.innerHTML='공모전 이력 '+(addCount+1);
	cell2.innerHTML = '<fieldset><legend>공모전이력</legend>'
						+'<table id="table_design">'
							+'<tr><th id="design">공모전 이름</th>'
								+'<td id="design"><input type="text" style="width:170px; height:20px;" name="cName'+addCount+'"></td>'
							+'</tr>'
							+'<tr><th id="design">공모전 기간</th>'
								+'<td id="design"><input style="width:170px;height:20px;" type="text" id="period'+addCount+'_1" name="period'+addCount+'_1" onchange="checkPeriod(this);">&nbsp;~&nbsp;'
												+'<input style="width:170px;height:20px;" type="text" id="period'+addCount+'_2" name="period'+addCount+'_2" onchange="checkPeriod(this);">'
												+'<input type="text" hidden="" id="period'+addCount+'" name="period'+addCount+'" value="">'+'<span style="margin-left:8px; font-size:5px; color:#A9D0F5;">기간은 년,월,일 순서로 0000-00-00으로 입력해주세요</span></td>'
							+'</tr>'
							+'<tr><th id="design">담당역할</th>'
								+'<td id="design"><select id="part" onchange="select(this)" name=mainRole'+addCount+'>'
													+'<option selected>담당 역할</option>'
													+'<option value="developer">개발자</option>'
													+'<option value="desiner">디자이너</option>'
													+'<option value="planner">기획자</option>'
													+'<option value="etc">etc</option></select>'
												+'<div id="role'+addCount+'"></div>'
												+'<input style="width:170px;height:20px;" type="text" id="detailRole'+addCount+'" name="detailRole'+addCount+'">'
								+'</td>'
							+'</tr>'
							+'<tr><th id="design">수상내역</th>'
								+'<td id="design"><input style="width:170px;height:20px;" type="text" placeholder="ex)입선" name="award'+addCount+'"></td>'
							+'</tr>'
							+'<tr><th id="design">상세내용</th>'
								+'<td id="design"><textarea rows="12" cols="40" placeholder="필요에 따라 입력해주세요.\n어떤 활약을 펼쳤는지 간단하게 작성해주시면 도움이 됩니다." name=detail'+addCount+'></textarea></td>'
							+'</tr>'
						+'</table>'
					+'</fieldset>';
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
//핸드폰 번호 입력시에 4자리의 번호만 입력할 수 있도록 하기. 
function checktel(tel){
    var num_pattern = /^\d{4}$/;  // 정규표현식 사용. []안에서 ^는 '일치하지 않는'을 의미한다.
    if(!num_pattern.exec(tel.value)) { //exec는 정규표현식 패턴에 맞는 문자열 탐색
        alert("해당 항목에는 4자리의 숫자만 사용할수 있습니다.\n다른 문자는 자동적으로 제거 됩니다.");
        tel.value = tel.value.replace(/^\d{4}$/g,''); //숫자를 제외한 문자열 내 모든 패턴(g=global)찾아 빈문자열로 대체.
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
//공모전 기간 형식 지정 함수
function checkPeriod(obj) {
    var pattern = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;  // 숫자랑 -만 입력 가능, ^시작, $끝
    				//19나 20으로 시작하고 두개의 숫자가 옮. - 이후 0으로 시작하는 1~9월 또는 1로시작하는 10~12월.
   	if(!pattern.exec(obj.value)) { //공백 체크, exec는 정규표현식 패턴에 맞는 문자열 탐색
       	alert("\n정확한 년,월,일을 입력하세요.\n해당 항목에는 0000-00-00형식만 사용 할 수 있습니다.\n자동적으로 제거 됩니다.");
       	obj.value = obj.value.replace(/.*/,''); //제거
	}
}
//미리보기 이미지를 기본으로 세팅
function setDefaultImg(){
	memberJoin.proimg.src = "/sp/img/프로필.png";
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
			var img = memberJoin.proimg; //미리보기 이미지를 띄울 객체(img태그)
			img.src = reader.result;
		};
	}
}
function formCheck(){
	memberJoin.addCount.value = addCount; // 공모전 상세이력 한개도 추가 안했을 때, 0전송됨.
	memberJoin.contact.value = memberJoin.headtel.value +"-"+ memberJoin.tel1.value +"-"+ memberJoin.tel2.value;
	for(i=0; i<addCount; i++){
		document.getElementById("period"+i).value = document.getElementById('period'+i+'_1').value
													+'~'+document.getElementById('period'+i+'_2').value;
	}
	return true;
}
</script>
<body>
<%@include file="/header.jsp"%>
<section>
	<article>
		<form name="memberJoin" action="memberJoin_ok.jsp" method="post" onsubmit="return formCheck()">
			<!-- 이전 필수 가입페이지에서 넘어오는 파라미터들 -->
			<input type="text" hidden="" name="idEmail" value="<%=mdto.getidEmail()%>">
			<input type="text" hidden="" name="pwd" value="<%=mdto.getPwd()%>">
			<input type="text" hidden="" name="MName" value="<%=mdto.getMName()%>">
			<input type="text" hidden="" name="fieldMajor" value="<%=mdto.getFieldMajor()%>">
			<input type="text" hidden="" name="emailAgreement" value="<%=mdto.getEmailAgreement()%>">
			<input type="text" hidden="" name="addCount" value="">
		<h1 >회원가입</h1>
		<div id="memberinput">회원정보 입력</div>
		<fieldset>
		<legend>추가입력정보</legend>
			<table id="table_design" >
				<tr>
					<td align="center" class="height_170px" colspan="2">
						<img width="150" height="150" name="proimg" src="/sp/img/프로필.png">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" class="height_50px">
						<input type="file" name="picture" onchange="showImg(this);" accept="">
					</td>
				</tr>
				<tr>
					<th class="height_50px">핸드폰번호
						<select name="headtel">
							<option>010</option>
							<option>011</option>
							<option>018</option>
						</select>-
							<input style="width:70px;height:15px;" type="text" name="tel1" maxlength="4" onchange="checktel(this);">-
							<input style="width:70px;height:15px;" type="text" name="tel2" maxlength="4" onchange="checktel(this);">
							<input style="text" hidden="" name="contact" value="">
					</th>
					<td>핸드폰 번호 공개 동의
						<input type="radio" id="r1" name="contactAgreement" value="true"/>
    					<label for="r1"><span></span>예</label>
    					<input type="radio" id="r2" name="contactAgreement" value="false" checked="checked"/>
    					<label for="r2"><span></span>아니오</label>
    				</td>
				</tr>
				<tr>
					<th class="height_50px">카카오톡ID
						<input style="width:170px;height:20px;" type="text" name="kakaoId" placeholder="내용을 입력해주세요" onkeyup="checkKakaoId(this);">
					</th>
					<td>카카오톡ID 공개 동의
						<input type="radio" id="r3" name="kakaoIdAgreement" value="true"/>
    					<label for="r3"><span></span>예</label>
    					<input type="radio" id="r4" name="kakaoIdAgreement" value="false" checked="checked"/>
    					<label for="r4"><span></span>아니오</label></td>
				</tr>
				<tr>
					<td id="design" align="center" colspan="2">연락을받고싶은 항목에 정보를 입력해주세요.<br>이메일보다 빠르게 상대방과 연락을 주고 받을 수 있습니다.</td>
				</tr>
			</table>
			<table id="table_design2">
				<tr>
					<th id="design">출생년도</th>
					<td id="design">
						<select name="birthYear">
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
					<th id="design">지역</th>
					<td id="design">
						<select onchange="addOption(this)" name="sido">
							<option selected>선택해주세요</option>
							<option >서울특별시</option>
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
						<select hidden="" name="sigungu"> <!-- 추가옵션 달릴 부분 -->
							<option selected>선택해주세요</option>
						</select>
					</td>
				</tr>
				<tr>
					<th id="design">공모전 이력&nbsp;</th>
					<td id="design">
						<input type="button" value="+" onclick="pageAdd();">&nbsp;
						<input type="button" value="-" onclick="pageDel();">
					</td>
				</tr>
				<tbody id="tb">
				</tbody>
				<tr>
					<th>자기소개</th>
					<td>
						<textarea name="mProfile" rows="12" cols="78" onkeyup="checkLength(this);" placeholder="자신이 현재 관심있는 분야 /프로젝트를 작성해주세요."></textarea>
						<input type="text" readonly="readonly" name="lengthinfo" style="border: none;">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input id="join" type="submit" value="가입하기">
					</td>
				</tr>
			</table>
		</fieldset>
		</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>