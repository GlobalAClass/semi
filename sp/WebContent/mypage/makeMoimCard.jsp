<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<script type="text/javascript">
function rcClick(){
	var result = confirm('모집을 종료하시겠습니까?\n주의! 종료 후 복구할 수 없습니다.');
    if(result==true){
    	document.all.rc.style.background="red";
    	document.all.rc.value="모집 종료";
    	document.all.rc.disabled="true";
    	}
}
</script>
<style>
table{
	border: gray 1px solid;
	padding: 10px;
	width:820px;
}
.pfimg{
	width:50px;
	height:50px;
	padding:2px;
}
.t1{
	width: 108px;
	height: 50px;
	font-size: 22px;
	font-weight: bold;
	text-align: center;
}
.t2{
	width: 108px;
	height:50px;
	font-weight: bold;
	text-align: center;
}
.t3{
	color: #424242;
	font-weight: bold;
	background: #E6E6E6;
}
.t4{
	width: 50px;
	height:50px;
	font-weight: bold;
	text-align: center;
}
.t5{
	border-top: gray 1px dotted;
	border-bottom: gray 1px dotted;
}
.btn{
	width:140px;
	height:40px;
	background: lightgray;
	font-size:15px;
	font-weight: bold;
}
.btn:hover, .hvr:active{
	background: gray;
	cursor: pointer;
}
#rbtn{
	width:100px;
	height:40px;
	background: green;
	font-size:15px;
	color:white;
}
#rbtn:hover, .hvr:active{
	background: #0B3B0B;
	cursor: pointer;
}
</style>
<%
String path = request.getServletContext().getRealPath("\\")+"\\img\\profile\\";
%>
<table style="margin-bottom:40px;">
	<tr>
		<td colspan="6" style="font-size:20px;font-weight:bold;"><%=compName %></td><td align="right" colspan="4"><input type="button" value="모집중" id="rbtn" onclick="rcClick();"></td>
	</tr>
	<tr>
		<td style="font-size:20px;" colspan="9"><%=matchName %></td>
	</tr>
	<tr>
		<td class="t3" colspan="9">현재 모임에 존재하는 사람</td>
	</tr>
	<%
	ArrayList<MatchOriginalDTO> origlist = mdao.moimOriginInfo(match_ix);
	int o_length = origlist.size();
	
	//직업마다 색깔 다르게 설정하는 메소드.
	//
	String color[] = mdao.setRoleColor(myMainRole);
	
	if(o_length==0){
		%><tr>
		<td class="pfimg"><img src="<%=mdao.setProfile(member_ix,path) %>" class="pfimg"></td>
		<td class="t1"><%=crt_name %></td>
		<td class="t2" style="color:<%=color[0]%>;background:<%=color[1]%>;"><%=myMainRole %><br><%=myDetailRole %></td>
		</tr><%
	}else{
	%>
	<tr>
		<td class="pfimg"><img src="<%=mdao.setProfile(member_ix,path) %>" class="pfimg"></td>
		<td class="t1"><%=crt_name %></td>
		<td class="t2"><%=myMainRole %><br><%=myDetailRole %></td>
		<%
		for(int j=0;j<o_length;j++){
			if(o_length>2){
				out.println("</tr><tr>");
			}
			String o_mainRole = origlist.get(j).getogMainRole();
			String o_detailRole = origlist.get(j).getogDetailRole();
			String o_cnt = origlist.get(j).getmemberNumber();
			
			String o_color[] = mdao.setRoleColor(o_mainRole);
		%>
		<td class="pfimg"><img src="/sp/img/profile_default.jpg" class="pfimg"></td>
		<td class="t2" style="color:<%=o_color[0]%>;background:<%=o_color[1]%>;"><%=o_mainRole %><br><%=o_detailRole %></td>
		<td class="t4"><%=o_cnt %>명</td>
		<%
		}
		%>
	</tr>
	<%
	}
	%>
	<tr>
		<td class="t3" colspan="9">승인 처리된 사람</td>
	</tr>
	<tr>
		<td class="pfimg"><img src="/sp/img/profile.jpg" class="pfimg"></td>
		<td class="t1">김영희
		<td class="t2">developer<br>IOS</td>
		<td class="pfimg"><img src="/sp/img/profile.jpg" class="pfimg"></td>
		<td class="t1">김영희
		<td class="t2">developer<br>IOS</td>
		<td class="pfimg"><img src="/sp/img/profile.jpg" class="pfimg"></td>
		<td class="t1">김영희
		<td class="t2">developer<br>IOS</td>
	</tr>
	<tr>
		<td class="t3" colspan="9">이 모임에 지원중인 사람</td>
	</tr>
	<%
	ArrayList<MemberDTO> applyList = mdao.moimApplyInfo(match_ix);
	ArrayList<MatchWantedDTO> applyRoleList = mdao.moimApplyRole(match_ix);
	int applyIdx[] = mdao.moimApplyIdx(match_ix);
	
	int a_length = applyIdx.length;
	if(a_length==0){
		%><tr><td colspan="9">모임에 지원한 사람이 없습니다.</td></tr><%
	}else{
		for(int k=0;k<a_length;k++){
			int a_member_ix = applyList.get(k).getMemberIx();
			String a_name = applyList.get(k).getMName();
			String a_mainRole = applyRoleList.get(k).getwMainRole();
			String a_detailRole = applyRoleList.get(k).getwDetailRole();
			
			String a_color[] = mdao.setRoleColor(a_mainRole); //0번째에 글자색, 1번째에 배경색 리턴해줌
	%>
	<tr>
		<td class="pfimg"><img src="<%=mdao.setProfile(a_member_ix,path) %>" class="pfimg"></td>
		<td class="t1"><%=a_name%></td>
		<td class="t2" style="color:<%=a_color[0]%>;background:<%=a_color[1]%>;"><%=a_mainRole %><br><%=a_detailRole %></td>
		<td align="center" colspan="4">
		<form name="makeMoim" action="makeMoimDetail.jsp" method="post">
			<input type="submit" class="btn" value="지원글 상세보기">
			<input type="hidden" name="member_ix" value="<%=a_member_ix%>">
			<input type="hidden" name="match_apply_ix" value="<%=applyIdx[k]%>">
		</form>
		</td>
		<td align="center" colspan="2">
			<a style="color:green;font-weight: bold;margin-right:20px;">승인</a>
			<a style="color:red;font-weight: bold;">삭제</a>
		</td>
	</tr>
	<%
		}
	}
	%>
	<tr>
		<td align="right" colspan="9">
		<input type="button" value="수정하기" class="btn" onclick="javascript:location.href='/sp/mypage/makeMoimCardModify.jsp?ix=<%=comp_ix%>&mix=<%=match_ix%>'">
		<input type="button" value="삭제하기" class="btn" onclick="javascript:location.href='/sp/mypage/makeMoimCardDelete.jsp?match_ix=<%=match_ix%>'">
		</td>
	</tr>
</table>