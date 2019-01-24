<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<style>
.t1{
	color: gray;
	font-weight: bold;
	font-size: 12px;
}
.t2{
	font-size: 15px;
}
.t3{
	font-size: 15px;
	font-weight: bold;
}
#card{
	width: 700px;
	height: 200px;
	border: gray solid 0.5px;
	padding: 2px;
	margin:10px;
}
</style>
<form name="CompetitionMoimCard" action="CompetitionMoimCard_ok.jsp">
<% 
for(int i=0;i<arr.size();i++){
	int member_ix=arr.get(i).getMemberIx();
	
	File proimg=new File(request.getServletContext().getRealPath("\\")+"\\img\\profile\\"+member_ix);
	File[] files=proimg.listFiles();
	String imgpath;
	if(files.length!=0){
		imgpath="/sp/img/profile/"+member_ix+"/"+files[0].getName();
	}else{
		imgpath="/sp/img/profile_default.jpg";
	}
	%>
	<table id="card">
	<tr>
		<td class="t1" colspan="4" align="right"><%=arr.get(i).getWriteDate()%></td>
	</tr>
	<tr>
		<td rowspan="5" align="justify"><img src="<%=imgpath%>" style="width:120px;height:120px;padding:2px;"></td>
		<td class="t2" colspan="3">[<%=dto.getField()%>]</td>
	</tr>
	<tr>
		<td colspan="2" style="width:400px;font-weight: bold; font-size:15px"><%=dto.getCName()%></td>
	</tr>
	<tr>
		<td style="font-size:20px;font-weight:bold;" colspan="3"><%=arr.get(i).getMatchName()%>&nbsp;|&nbsp;모임주최자</td>
	</tr>
	<tr>
		<td class="t3">현재인원/총인원</td>
		<td style="width:330px;"><%=arr.get(i).getOriginalMemberNumber()%>&nbsp;/&nbsp;5</td>
	</tr>
	<tr>
		<td class="t3">모집 인원</td>
		<td style="width:330px;">
		<%
		int match_ix = arr.get(i).getMatchIx();
		ArrayList<MatchWantedDTO> arr2=mwdao.MatchAddPeople(match_ix);
		for(int j=0;j<arr2.size();j++){
			%>
			<%=arr2.get(j).getwMainRole()%>
			<%=arr2.get(j).getWantedNumber()%>
			<%
		}
		%>
		</td>
	</tr>
</table>
	<%
}
%>
</form>	