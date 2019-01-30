<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%@ page import="hsearch.*" %>
<%@page import="java.io.File"%>

<%
	Calendar c = Calendar.getInstance(); //나이 계산을 위해 년도 받기.
	int year = c.get(Calendar.YEAR);
	
	int scrapMemberIdx = myScrapHumans.get(i).getLeft().getMemberIx();
	
	//카드에 출력될 프로필 가져오기.
	File userdir = new File(request.getServletContext().getRealPath("\\")+ "\\img\\profile\\"+scrapMemberIdx);
	File[] files = userdir.listFiles();
	String imagpath;
	if(files.length>0){
		imagpath = "/sp/img/profile/"+scrapMemberIdx+"/"+files[0].getName();
	}else{
		imagpath = "/sp/img/profile_default.jpg";
	}
	
	String mName = myScrapHumans.get(i).getLeft().getMName();
	String birthYear = myScrapHumans.get(i).getRight().getBirthYear();
	int age = year-Integer.parseInt(birthYear)+1;
	String fieldMajor = myScrapHumans.get(i).getLeft().getFieldMajor();
	String sido = myScrapHumans.get(i).getRight().getSido();
	String sigungu = myScrapHumans.get(i).getRight().getSigungu();
	if(sigungu==null || sigungu.equals("")){
		sigungu = "";
	}
	String idEmail = myScrapHumans.get(i).getLeft().getidEmail();
	
%>
<html>
<script>

function scrapDelete(){
	var result = confirm('스크랩을 삭제할까요?\n주의! 복구되지 않습니다.');
	
	var scrapHuman = document.getElementById("scrapHuman");
	
	if(result==true){
		scrapHuman.action = "myScrapHumanCard_ok.jsp";
	}
}
function goDetail(mix){
	location.href='/sp/humansearch/humanSelect.jsp?member_ix='+mix;
}
</script>
<style>

table{
	width: 350x;
	height: 130px;
	border: gray solid 0.5px;
	padding: 2px;
	border-collapse: collapse; 
	border-spacing: 0;
}
table :hover{
	background: #E9F0FD;
	font-weight: bold;
	cursor:pointer;
}
</style>
<div onclick="goDetail(<%=scrapMemberIdx%>)">
<span style="<% if(i%2==0){out.print("float: left;");} else{out.print("float: right;");}%>">
<table>
	<tr>
		<td rowspan="3" style="width:100px"><img src="<%=imagpath %>" style="width:80px;height:80px;margin:10px;"></td>
		<td style="font-weight: bold; font-size:30px; width : 100px;"><%=mName %></td>
		<td style="width:90px;font-size:15px; color:gray;"><%=age %>세</td>
		<td style="margin-right: 10px;"><%=fieldMajor %></td>
	</tr>
	<tr>
		<td colspan="2"><img src="/sp/img/location.png" style="width:20px;height:20px;padding-right:5px;"><%=sido %> <%=sigungu %></td>
		<td align="right" rowspan="2">
			<form id="scrapHuman" name="scrapHuman" action="" method="post">
				<input type="image" src="/sp/img/heart.jpg" style="width:30px;height:30px;padding:5px;" onclick="scrapDelete()">
				<input type="hidden" value="<%=scrapMemberIdx %>" name="scrapMemberIdx">
				<input type="hidden" value="<%=member_ix %>" name="memberIx">
			</form>
		</td>
	</tr>
	<tr>
		<td colspan="2"><img src="/sp/img/mail.png"  style="width:20px;height:15px;padding-right:5px;"><%=idEmail %></td>
	</tr>
</table>
</span>
</div>
</html>