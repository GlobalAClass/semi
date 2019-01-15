<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="member.MemberDTO" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="java.util.Date" %>


<jsp:useBean id="mdto" class="member.MemberDTO"/>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="member.MemberDAO" scope="session"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/mainLayout.css">
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
</style>
</head>
<script type="text/javascript">
//지역 선택시에 추가 옵션 보여주는 함수.
function addOption(obj){
	var option = obj.value;
	var ary;
	var addop = memberJoin.addop;
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
			memberJoin.addop.add(op);
		}
		memberJoin.addop.hidden=false;
	}else{
		memberJoin.addop.hidden=true;
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
var addCount = 1;
function pageAdd(){
	var tb = document.getElementById('tb');
	var row = tb.insertRow(tb.rows.length);
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	cell1.innerHTML='공모전 이력 '+addCount;
	cell2.innerHTML = '<fieldset><legend>공모전이력</legend>'
						+'<table id="table_design">'
							+'<tr><th id="design">공모전 이름</th>'
								+'<td id="design"><input type="text" style="width:170px; height:20px;" name="cName'+addCount+'"></td>'
							+'</tr>'
							+'<tr><th id="design">공모전 기간</th>'
								+'<td id="design"><input style="width:170px;height:20px;" type="text" name="period'+addCount+'_1">&nbsp;~&nbsp;<input style="width:170px;height:20px;" type="text" name="period'+addCount+'_2"></td>'
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
								+'<td id="design"><input style="width:170px;height:20px;" type="text" name="award'+addCount+'"></td>'
							+'</tr>'
							+'<tr><th id="design">상세내용</th>'
								+'<td id="design"><textarea rows="12" cols="40" name=detail'+addCount+'></textarea></td>'
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
		ary = [];
		break;
	}
	//버튼 추가
	for(i=0; i<ary.length;i++){
		var bu =  document.createElement("input");
		bu.type = "button";
		bu.value = ary[i];
		bu.style.marginRight = "4px";
		bu.onclick = function(){//기능 : 버튼 클릭시에 버튼 값이 자동으로 text에 입력
								//추가되는 이력의 버튼마다 해당 이력에만 작동해야하기 때문에 전역함수로 함수를 두지 않음!
								var str = new String('detailRole'+(addCount-1)); //addCount는 이미 1증가한 상태이므로 1빼줌.
								var detailtext = document.getElementById(str);
								detailtext.value = this.value;};
		role.append(bu);
	}
}
//핸드폰 번호 입력시에 번호만 입력할 수 있도록 하기.
function checktel(obj){
    var num_pattern = /[^0-9]/;  // 정규표현식 사용. ^ 뒤에오는 것은 해당 문자열로 시작하는 것을 뜻함.
    if(num_pattern.exec(obj.value)) { //exec는 정규표현식 패턴에 맞는 문자열 탐색
        alert("해당 항목에는 숫자만 사용할수 있습니다.\n다른 문자는 자동적으로 제거 됩니다.");
        obj.value = obj.value.replace(/[^0-9]/g,''); //숫자를 제외한 문자열 내 모든 패턴(g=global)찾아 빈문자열로 대체.
        return false;
    }
}
//공백,특수문자 제거 함수
function noSpaceThisForm(obj) {
    var space_pattern = /[\s\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/;  // 정규표현식에서 공백문자 = \s 또는 = |
    if(space_pattern.exec(obj.value)) { //공백 체크, exec는 정규표현식 패턴에 맞는 문자열 탐색
        alert("해당 항목에는 공백 및 특수문자를 사용할수 없습니다.\n자동적으로 제거 됩니다.");
        obj.value = obj.value.replace(/[\s\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g,''); //제거
        return false;
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
	var file = profile.files[0];
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
</script>
<body>
<%@include file="/header.jsp"%>
<section>
	<article>
		<form name="memberJoin" action="memberJoin_ok.jsp">
			<!-- 이전 필수 가입페이지에서 넘어오는 파라미터들 -->
			<input type="text" hidden="" name="idEmail" value="<%=mdto.getidEmail()%>">
			<input type="text" hidden="" name="pwd" value="<%=mdto.getPwd()%>">
			<input type="text" hidden="" name="MName" value="<%=mdto.getMName()%>">
			<input type="text" hidden="" name="fieldMajor" value="<%=mdto.getFieldMajor()%>">
			<input type="text" hidden="" name="emailAgreement" value="<%=mdto.getEmailAgreement()%>">
		<h1 >회원가입</h1>
		<div id="memberinput">회원정보 입력</div>
		<fieldset>
		<legend>추가입력정보</legend>
			<table id="table_design">
				<tr>
					<td>
						<img width="100" height="100" name="proimg" src="/sp/img/프로필.png">
						<script>
							
						</script>
					</td>
					<td>연락을받고싶은 항목에 정보를 입력해주세요.<br>
					빠르게 상대방과 연락을 주고 받을 수 있습니다.</td>
				</tr>
				<tr>
					<td><input type="file" name="profile" onchange="showImg(this);" accept=""></td>
					<th>핸드폰번호
						<select>
							<option>010</option>
							<option>011</option>
							<option>018</option>
						</select>-
							<input style="width:70px;height:15px;" type="text" name="tel" maxlength="4" onkeyup="checktel(this);">-
							<input style="width:70px;height:15px;" type="text" name="tel2" maxlength="4" onkeyup="checktel(this);">
					</th>
				</tr>
				<tr>
					<td id="design"></td>
					<th id="design">카카오톡ID
						<input style="width:170px;height:20px;" type="text" name="kakaoid" placeholder="내용을 입력해주세요" onkeyup="noSpaceThisForm(this);">
					</th>
				</tr>
			</table>
			<table id="table_design2">
				<tr>
					<th id="design">출생년도</th>
					<td id="design">
						<select>
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
						<select onchange="addOption(this)">
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
						<select hidden="" name="addop"> <!-- 추가옵션 달릴 부분 -->
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
						<textarea rows="12" cols="78" onkeyup="checkLength(this);"></textarea>
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