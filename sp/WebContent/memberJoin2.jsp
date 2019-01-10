<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<body>
<%@include file="/header.jsp"%>
<section>
	<article>
		<form name="memberJoin" action="memberJoin_ok.jsp">
		<h1>회원가입</h1>
		<div id="memberinput">회원정보 입력</div>
		<fieldset>
		<legend>추가입력정보</legend>
			<table id="table_design" >
				<tr>
					<td>
						<img width="100" height="100" src="/sp/img/프로필.png">
					</td>
					<td>연락을받고싶은 항목에 정보를 입력해주세요.<br>
					빠르게 상대방과 연락을 주고 받을 수 있습니다.</td>	
				</tr>
				<tr>
					<td><input type="file"></td>
					<th>핸드폰번호
						<select>
							<option>010</option>
							<option>011</option>
							<option>018</option>
						</select>-
							<input style="width:70px;height:15px;" type="text" name="tel" maxlength="4" required="required">-
							<input style="width:70px;height:15px;" type="text" name="tel2" maxlength="4" required="required">
					</th>
				</tr>
				<tr>
					<td id="design"><input type="button" value="기본설정">	</td>
					<th id="design">카카오톡ID
						<input style="width:170px;height:20px;" type="text" name="kakaoid" placeholder="내용을 입력해주세요" required="required">
					</th>
				</tr>
			</table>
			<table id="table_design2">
				<tr>
					<th id="design">출생년도</th>
					<td id="design">
						<select>
							<%
							for(int i=1935;i<=2019;i++){
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
						<select>
							<option selected>서울특별시</option>
							<!-- 강남구 강동구 강북구 강서구 관악구 광진구 구로구 금천구
							노원구 도봉구 동대문구 동작구 마포구 서대문구 서초구 성동구
							성북구 송파구 양천구 영등포구 용산구 은평구 종로구 중구 중랑구 -->
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
					</td>
				</tr>
				<tr>
					<th id="design">공모전 이력&nbsp;</th>
					<td id="design">
					<input type="button" value="+">&nbsp;
					<input type="button" value="-">
					</td>
				</tr>
				<tr>
					<th>자기소개</th>
					<td>
					<textarea rows="12" cols="78"></textarea>
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