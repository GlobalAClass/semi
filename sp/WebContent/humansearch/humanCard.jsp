<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%@ page import="hsearch.*" %>
<%@page import="java.io.File"%>

<jsp:useBean id="mddao" class="member.MemberDetailDAO"/>
<%!
	//
	public String manageNull(String str) {
		if (str == null || str.equals("") || str.equals("null")) {
			return "";
		} else {
			return str;
		}
	}
%>

<%
	Calendar c = Calendar.getInstance(); //나이 계산을 위해 년도 받기.
	int year = c.get(Calendar.YEAR);
	
	int i = Integer.parseInt(request.getParameter("i"));
	int user_ix = Integer.parseInt(request.getParameter("user_ix"));
	int member_ix = Integer.parseInt(request.getParameter("member_ix"));
	String mname = request.getParameter("mName");
	String birth = request.getParameter("birth");
	int age = year - Integer.parseInt(birth) + 1;
	String fieldMajor = request.getParameter("fieldMajor");
	String sido = request.getParameter("sido");
	String sigungu = request.getParameter("sigungu");
	String idemail = request.getParameter("idEmail");
	
	//카드에 출력될 프로필 가져오기.
	File userdir = new File(request.getServletContext().getRealPath("\\")+ "\\img\\profile\\"+member_ix);
	File[] files = userdir.listFiles();
	String imagpath;
	if(files.length>0){
		imagpath = "/sp/img/profile/"+member_ix+"/"+files[0].getName();
	}else{
		imagpath = "/sp/img/profile_default.jpg";
	}
	
	//해당 인원 스크랩여부 판단
	HumanScrapDAO hsdao = new HumanScrapDAO();
	boolean scrapcheck = hsdao.checkScrapHuman(user_ix, member_ix);
%>
<html>
<script>
function scrap(obj){
	if(obj.src == "http://localhost:9090/sp/img/heart.jpg"){
		obj.src = "/sp/img/unheart.jpg";
	}else{
		obj.src = "/sp/img/heart.jpg";
	}
	//window.location.reload();
}
<%if(mddao.getMemberDetailInfo(user_ix).getSearchAgreement().equals("true")){%>
function goDetail(obj){
	location.href='/sp/humansearch/humanSelect.jsp?member_ix='+obj.previousSibling.previousSibling.value;;
}
<%}else{%>
function goDetail(obj){
	alert('프로필에서 사람 검색 등록을 허용하셔야\n다른 사람을 볼 수 있습니다.');
}
<%}%>
</script>
<style>
span {
	margin: 20px 50px;
}
table{
	width: 450x;
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
<span style="<% if(i%2!=0){out.print("float: left;");} else{out.print("float: right;");}%>">
<input type="text" hidden="" id="mix" value="<%=member_ix %>">
<table onclick="goDetail(this)">
	<tr>
		<td rowspan="3" style="width:100px"><img src="<%=imagpath %>" style="width:80px;height:80px;margin:10px;"></td>
		<td style="font-weight: bold; font-size:30px; width : 200px;"><%=mname %></td>
		<td style="width:80px;font-size:15px; color:gray;"><%=age %></td>
		<td style="margin-right: 10px;"><%=fieldMajor %></td>
	</tr>
	<tr>
		<td colspan="2"><img src="/sp/img/location.png" style="width:20px;height:20px;padding-right:5px;"><%=sido %> <%=manageNull(sigungu) %></td>
		<td align="right" rowspan="2">
			<form name="humanCard" action="humanCard_ok.jsp" method="post">
				<input type="image" src="<%if(scrapcheck){out.print("/sp/img/heart.jpg");}else{out.print("/sp/img/unheart.jpg");} %>" 
					 style="width:30px;height:30px;padding:5px;" onclick="scrap(this)" name="submit">
				 	<input type="text" hidden="" value="<%=user_ix %>" name="user_ix">
					<input type="text" hidden="" value="<%=member_ix %>" name="member_ix">
					<input type="text" hidden="" value="<%=scrapcheck %>" name="scrapcheck">
			</form>
		</td>
	</tr>
	<tr>
		<td colspan="2"><img src="/sp/img/mail.png"  style="width:20px;height:15px;padding-right:5px;"><%=idemail %></td>
	</tr>
</table>
</span>
</html>