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
	border-spacing: 0;
}
#card :hover{
	background: #E9F0FD;
	cursor:pointer;
}
</style>
<form name="CompetitionMoimCard" action="CompetitionMoimCard_ok.jsp">
<% 
for(int i=0;i<arr.size();i++){
	int member_ix=arr.get(i).getMemberIx();
	String mn = dao.getMemberInfo(member_ix).getMName();
	
	File proimg=new File(request.getServletContext().getRealPath("\\")+"\\img\\profile\\"+member_ix);
	File[] files=proimg.listFiles();
	String imgpath;
	if(files.length!=0){
		imgpath="/sp/img/profile/"+member_ix+"/"+files[0].getName();
	}else{
		imgpath="/sp/img/profile_default.jpg";
	}
	
	
%>
<script>
function goDetail(obj){
	//alert(obj.previousSibling.previousSibling);
	location.href='/sp/Competition/CompetitionDetail.jsp?ix='+<%=ix%>+'&mix='+obj.previousSibling.previousSibling.value;
}
</script>
	<input type="text" hidden="" value="<%=arr.get(i).getMatchIx() %>">
	<table id="card" onclick="goDetail(this)">
	<tr>
		<td class="t1" colspan="4" align="right"><%=arr.get(i).getWriteDate()%></td>
	</tr>
	<tr>
		<td rowspan="6" align="justify" style="text-align: center;"><img src="<%=imgpath%>" style="width:120px;height:120px;padding:2px;"></td>
		<td class="t2" colspan="3">[<%=dto.getField()%>]</td>
	</tr>
	<tr>
		<td colspan="2" style="width:400px;font-weight: bold; font-size:15px"><%=dto.getCName()%></td>
	</tr>
	<tr>
		<td style="font-size:20px;font-weight:bold;" colspan="3">
			<%=arr.get(i).getMatchName()%>&nbsp;|&nbsp;<%=mn %>
		</td>
	</tr>
	<tr>
		<td class="t3">모임 지역</td>
		<td><%=arr.get(i).getSido() %> <%=arr.get(i).getSigungu() %><td>
	</tr>
	<tr>
		<%
		//모임 글에서 존재하는 팀원 수, 구하고 싶은 팀원 수 가져오기
		int ornum = Integer.parseInt(arr.get(i).getOriginalMemberNumber());
		int wnum = Integer.parseInt(arr.get(i).getTotalWantedNumber());
		//구하는 팀원에 대한 정보 받기
		int match_ix = arr.get(i).getMatchIx();
		ArrayList<MatchWantedDTO> arr2=mwdao.MatchAddPeople(match_ix);
		int le = arr2.size();
		//현재 인원 계산하기
		int curnum=ornum;
		for(int k=0;k<le;k++){
			curnum += Integer.parseInt(arr2.get(k).getRecruitedNumber());
		}
		%>
		<td class="t3">현재인원/총인원</td>
		<td style="width:330px;"><%=curnum%>&nbsp;/&nbsp;<%=(ornum+wnum)%></td>
	</tr>
	<tr>
		<td class="t3">모집 인원</td>
		<td style="width:330px;">
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
	<%
}
%>
</form>	