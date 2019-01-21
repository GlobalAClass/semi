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
	
	int i = Integer.parseInt(request.getParameter("i"));
	String member_ix = request.getParameter("member_ix");
	String mname = request.getParameter("mName");
	String birth = request.getParameter("birth");
	int age = year - Integer.parseInt(birth) + 1;
	String fieldMajor = request.getParameter("fieldMajor");
	String sido = request.getParameter("sido");
	String sigungu = request.getParameter("sigungu");
	String idemail = request.getParameter("idEmail");
	
	File userdir = new File(request.getServletContext().getRealPath("\\")+ "\\img\\profile\\"+member_ix);
	File[] files = userdir.listFiles();
	String imagpath;
	if(files.length>0){
		imagpath = "/sp/img/profile/"+member_ix+"/"+files[0].getName();
	}else{
		imagpath = "/sp/img/profile_default.jpg";
	}
%>
<html>
<style>
span {
	margin: 20px 50px;
}
table{
	width: 450x;
	height: 130px;
	border: gray solid 0.5px;
	padding: 2px;
}
</style>
<span style="<% if(i%2==0){out.print("float: left;");}else{out.print("float: right;");}%>">
<table>
	<tr>
		<td rowspan="3" style="width:100px"><img src="<%=imagpath %>" style="width:80px;height:80px;padding:2px;"></td>
		<td style="font-weight: bold; font-size:30px; width : 200px;"><%=mname %></td>
		<td style="width:80px;font-size:15px; color:gray;"><%=age %></td>
		<td align="right"><%=fieldMajor %></td>
	</tr>
	<tr>
		<td colspan="2"><img src="/sp/img/location.png" style="width:20px;height:20px;padding-right:5px;"><%=sido %> <%=sigungu %></td>
		<td align="right" rowspan="2"><img src="/sp/img/heart.jpg" style="width:30px;height:30px;padding:5px;"></td>
	</tr>
	<tr>
		<td colspan="3"><img src="/sp/img/mail.png"  style="width:20px;height:15px;padding-right:5px;"><%=idemail %></td>
	</tr>
</table>
</span>
</html>