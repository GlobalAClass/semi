<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#table_design{
	width: 480px;
	height: 350px;
}
#design{
	border-bottom: 1px dotted black;
}
fieldset{
	width: 480px;
	height: 350px;
}
</style>
</head>
<body>
<section>
	<article>
		<form name="memberJoin" action="memberJoin_ok.jsp">
		<fieldset>
		<legend>공모전이력</legend>
			<table id="table_design">
				<tr>
					<th id="design">공모전 이름</th>
					<td id="design"><input type="text" style="width:170px;height:20px;" name="content_name"></td>
				</tr>
				<tr>
					<th id="design">공모전 기간</th>
					<td id="design">
					<input style="width:170px;height:20px;" type="text" name="content_day">&nbsp;~&nbsp;
					<input style="width:170px;height:20px;" type="text" name="content_day2">
					</td>
				</tr>
				<tr>
					<th id="design">담당역할</th>
					<td id="design">
						<select>
							<option>대분류</option>
						</select>
					<input style="width:170px;height:20px;" type="text" name=""></td>
				</tr>
				<tr>
					<th id="design">수상내역</th>
					<td id="design"><input style="width:170px;height:20px;" type="text" name="award"></td>
				</tr>
				<tr>
					<th id="design">상세내용</th>
					<td id="design">
					<textarea rows="12" cols="40"></textarea>
					</td>
				</tr>
			</table>
		</fieldset>
		</form>
	</article>
</section>
</body>
</html>