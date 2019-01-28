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
for(int i=0;i<arr.size();i++){
	int member_ix=arr.get(i).getMemberIx();
	String mn = dao.getMemberInfo(member_ix).getMName();
	//공모전 이름 / 분야 정보 DAO
	int matchIx=arr.get(i).getMatchIx();
	CompetitionInfoDTO dto=msdao.CompetitionMoimSearchCard(matchIx);
	//구하는 팀원 정보 DAO
	ArrayList<MatchWantedDTO> arr2=mwdao.MatchAddPeople(matchIx);
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
<a href="/sp/Competition/CompetitionDetail.jsp?ix=<%=dto.getCompetitionInfoIx()%>&mix=<%=matchIx%>">
<table>
	<tr>
		<td class="t1" colspan="3" align="right"><%=arr.get(i).getWriteDate()%></td>
	</tr>
	<tr>
		<td rowspan="3" align="justify"><img src="<%=imgpath%>" style="width:80px;height:80px;padding:2px;"></td>
		<td class="t2" colspan="2">[<%=dto.getField()%>]</td>
	</tr>
	<tr>
		<td colspan="2" style="width:400px;font-weight: bold; font-size:20px"><%=dto.getCName()%></td>
	</tr>
	<tr>
		<td class="t2" colspan="2"><%=arr.get(i).getMatchName()%>&nbsp;|&nbsp;<%=mn%></td>
	</tr>
	<tr>
		<td></td>
		<td class="t3" colspan="2"><%=arr.get(i).getSido()%>&nbsp;&nbsp;<%=arr.get(i).getSigungu()%></td>
	</tr>
	<tr>
		<%
		//모임 글에서 존재하는 팀원/ 구하고 싶은 팀원수 가져오기
		int ornum =Integer.parseInt(arr.get(i).getOriginalMemberNumber());
		int wnum=Integer.parseInt(arr.get(i).getTotalWantedNumber());
		int le=arr2.size();
		//현재 인원 계산
		int curnum=ornum;
		for(int z=0;z<le;z++){
			curnum+=Integer.parseInt(arr2.get(z).getRecruitedNumber());
		}
		%>
		<td></td>
		<td class="t3">현재인원/총인원</td>
		<td><%=curnum%>&nbsp;/&nbsp;<%=ornum+wnum%></td>
	</tr>
	<tr>
		<td></td>
		<td class="t3">모집 인원</td>
		<td>
		<%
		for(int j=0;j<le;j++){
			%>
			<%=arr2.get(j).getwMainRole()+" - "+arr2.get(j).getwDetailRole()%> : 
			<%=arr2.get(j).getRecruitedNumber()+" / "+arr2.get(j).getWantedNumber()%>명
			<br>
			<%
		}
		%>
		</td>
	</tr>
</table>
</a>
</form>
		<%
	}
%>
</article>
</section>