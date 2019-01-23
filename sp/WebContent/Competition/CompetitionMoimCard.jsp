<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<% 
for(int i=0;i<arr.size();i++){
	%>
	<table id="card">
	<tr>
		<td class="t1" colspan="3" align="right"><%=arr.get(i).getWriteDate()%></td>
	</tr>
	<tr>
		<td rowspan="3" align="justify"><img src="/sp/img/profile.jpg" style="width:80px;height:80px;padding:2px;"></td>
		<td class="t2" colspan="2">[<%=dto.getField()%>]</td>
	</tr>
	<tr>
		<td colspan="2" style="width:400px;font-weight: bold; font-size:23px"><%=dto.getCName()%></td>
	</tr>
	<tr>
		<td class="t2" colspan="2"><%=arr.get(i).getMatchName()%>&nbsp;|&nbsp;모임주최자</td>
	</tr>
	<tr>
		<td></td>
		<td class="t3">현재인원/총인원</td>
		<td>1&nbsp;/&nbsp;5</td>
	</tr>
	<tr>
		<td></td>
		<td class="t3">모집 인원</td>
		<td>
		<%
		for(int j=0;j<arr2.size();j++){
			%>
			<%=arr2.get(j).getMainRole()%>
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
