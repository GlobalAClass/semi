<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
section{
	width: 1200px;
	height: auto;
}
.t1{
	color: gray;
	font-weight: bold;
	font-size: 12px;
}
.t2{
	font-size: 14px;
}
.t3{
	font-size: 14px;
	font-weight: bold;
}
table{
	width: 600x;
	height: 250px;
	border: gray solid 0.5px;
	margin: 40px;
	border-collapse:collapse;
}
table :hover{
	background: #E9F0FD;
	font-weight: bold;
	cursor:pointer;
}
section a{
	text-decoration:none;
	color:black;
}
</style>
<section>
<article>
<%
for(int i=0;i<search.size();i++){
	//공모전 주최자이름 가져오기
	int member_ix=search.get(i).getRight().getMemberIx();
	String mn = dao.getMemberInfo(member_ix).getMName();
	//프로필 이미지 가져오기
	File proimg=new File(request.getServletContext().getRealPath("\\")+"\\img\\profile\\"+member_ix);
	File[] files=proimg.listFiles();
	String imgpath;
	if(files.length!=0){
		imgpath="/sp/img/profile/"+member_ix+"/"+files[0].getName();
	}else{
		imgpath="/sp/img/profile_default.jpg";
	}
%>
<form>
<a href="/sp/Competition/CompetitionDetail.jsp?ix=<%=search.get(i).getRight().getCompetitionInfoIx()%>&mix=<%=search.get(i).getRight().getMatchIx()%>">
<table>
	<tr>
		<td class="t1" colspan="3" align="right"><%=search.get(i).getRight().getWriteDate()%></td>
	</tr>
	<tr>
		<td rowspan="3" align="justify"><img src="<%=imgpath%>" style="width:80px;height:80px;padding:2px;"></td>
		<td class="t2" colspan="2">
		[<%=search.get(i).getLeft().getField()%>]
		</td>
	</tr>
	<tr>
		<td colspan="2" style="width:400px;font-weight: bold; font-size:20px"><%=search.get(i).getLeft().getCName()%></td>
	</tr>
	<tr>
		<td class="t2" colspan="2"><%=search.get(i).getRight().getMatchName()%>&nbsp;|&nbsp;<%=mn%></td>
	</tr>
	<tr>
		<td></td>
		<td class="t3">모임 지역</td>
		<td><%=search.get(i).getRight().getSido()%>&nbsp;&nbsp;<%=search.get(i).getRight().getSigungu()%></td>
	</tr>
	<tr>
		<td></td>
		<td class="t3">나이제한</td>
		<%
		String age = search.get(i).getRight().getAgeRestriction();
		if(!age.equals("무관")){
			%><td><%=age%>이하</td><%
		}else{
			%>
			<td><%=age%></td>
			<%
		}
		%>
	</tr>
	<tr>
		<%
		//모임 글에서 존재하는 팀원 / 구하고 싶은 팀원수 가져오기
		int ornum =Integer.parseInt(search.get(i).getRight().getOriginalMemberNumber());
		int wnum=Integer.parseInt(search.get(i).getRight().getTotalWantedNumber());
		%>
		<td></td>
		<td class="t3">현재인원/총인원</td>
		<td><%=ornum%>&nbsp;/&nbsp;<%=ornum+wnum%></td>
	</tr>
</table>
</a>
</form>
		<%
	}
%>
</article>
</section>