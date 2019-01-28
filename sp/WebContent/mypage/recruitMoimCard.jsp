<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<script>
function recruitDel(){
	var result = confirm('모임 지원을 삭제할까요?\n주의! 복구되지 않습니다.');
	
	var recruitMoimCard = document.getElementById("recruitMoimCard");
	
	if(result==true){
		
		recruitMoimCard.matchApplyIx.value=<%=applylist[i]%>; //해당 모임 신청글에 대한 idx		
		recruitMoimCard.memberIx.value=<%=member_ix%>;		
		recruitMoimCard.matchIx.value=<%=match_ix%>;		
		recruitMoimCard.matchWantedIx.value=<%=match_wanted_ix%>;		
		
		recruitMoimCard.action = "recruitMoimCard_ok.jsp";
	}
}
function goDetail(){
	location.href='/sp';
}
</script>
<style>
table{
	border: gray 1px solid;
	padding: 10px;
	width:700px;
}
.pfimg{
	width:80px;
	height:80px;
	padding:5px;
}
.btn{
	width:160px;
	height:40px;
	font-size:15px;
	font-weight: bold;
	background: lightgray;
}
.btn:hover, .hvr:active{
	background: gray;
	cursor: pointer;
}

<%
//카드에 출력될 프로필 가져오기.
File userdir = new File(request.getServletContext().getRealPath("\\")+ "\\img\\profile\\"+m_ix);
File[] files = userdir.listFiles();
String imagpath;
if(files.length>0){
	imagpath = "/sp/img/profile/"+m_ix+"/"+files[0].getName();
}else{
	imagpath = "/sp/img/profile_default.jpg";
}

%>
</style>
<table style="width:700px;margin-left:50px;margin-bottom:40px;">
	<tr>
		<td align="right" colspan="4" style="color:<%=state.equals("false")?"green":"red"%>;font-weight:bold;font-size:20px;"><%=state.equals("false")?"모집 진행중":"모집 완료"%></td>
	</tr>
	<tr>
		<td class="pfimg" rowspan="3"><img src="<%=imagpath %>" class="pfimg"></td>
		<td style="font-size:18px;font-weight:bold;" colspan="3"><%=compName[i] %></td>
	</tr>
	<tr>
		<td colspan="3" style="font-size:22px;"><%=moimName %> | <%=makerName %></td>
	</tr>
	<tr>
		<td colspan="2"><b style="margin-right:10px;margin-bottom:20px;">내가 지원한 역할</b><%=myrole %></td>
	</tr>
	<tr>
		<td align="center" colspan="4">
		<form id="recruitMoimCard" name="recruitMoimCard" action="" method="post">
			<input type="submit" value="지원 삭제하기" class="btn" onclick="recruitDel()">
			<input type="hidden" id="matchApplyIx" name="matchApplyIx" value="">
			<input type="hidden" id="memberIx" name="memberIx" value="">
			<input type="hidden" id="matchIx" name="matchIx" value="">
			<input type="hidden" id="matchWantedIx" name="matchWantedIx" value="">
		</form>
		</td>
	</tr>
</table>
