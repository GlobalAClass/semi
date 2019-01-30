<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<script type="text/javascript">
function rcClick(mix){
	var rbtn = document.getElementById('rbtn');
	var result = confirm('모집을 종료하시겠습니까?\n주의! 종료 후 복구할 수 없습니다.');
    if(result==true){
    	rbtn.style.background="red";
    	rbtn.value="모집 종료";
    	rbtn.disabled="true";
    	location.href="/sp/mypage/makeMoimCardStop.jsp?mix="+mix;
    	}
}
function pick(btn,name,m,w,a,i){
	var insertname = name;
	var res = confirm(insertname+'님을 모임에 추가하시겠습니까?');
	
	if(res==true){
		location.href = '/sp/mypage/makeMoimCardPick.jsp?mix='+m+'&wix='+w+'&aix='+a+'&ix='+i;
	}
}

function deleteApply(idx){
	var res = confirm('모집을 삭제하시겠습니까?\n주의! 삭제 후 복구할 수 없습니다.');
	if(res==true){
		location.href='/sp/mypage/makeMoimCardDelete.jsp?match_ix='+idx;
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
	font-size:15px;
	color:white;
}
#rbtn:hover, .hvr:active{
	background: #0B3B0B;
	cursor: pointer;
}
#yes{
	color:green;
	margin-right:20px;
}
#yes:hover{
	font-weight: bold;
	text-decoration: underline;
	cursor: pointer;
}
</style>
<%
//각자 프로필 경로가 필요한 메소드에서 사용하기 위해 루트 경로 먼저 가져옴.
String path = request.getServletContext().getRealPath("\\")+"\\img\\profile\\";

//현재 내가 가지고 있는 모임 상태값
String comp_state = matchlist.get(i).getCompletedState();
String background;
String value;
boolean disabled;
if(comp_state.equals("true")){
	background="red";
	value="모집종료";
	disabled=true;
}else{
	background="green";
	value="모집중";
	disabled=false;
}
%>
<table style="margin-bottom:40px;">
	<tr>
		<td colspan="6" style="font-size:20px;font-weight:bold;">공모전명 : <%=compName %></td>
		<td align="right" colspan="4">
		<input type="button" value="<%=value %>" id="rbtn" style="background:<%=background%>;" <%if(disabled){out.print("disabled");} %> onclick="rcClick(<%=match_ix%>);">
		</td>
	</tr>
	<tr>
		<td style="font-size:20px;height:40px;" colspan="9">모임명 : <%=matchName %></td>
	</tr>
	<tr>
		<td class="t3" colspan="9">현재 모임에 존재하는 사람</td>
	</tr>
	<%
	ArrayList<MatchOriginalDTO> origlist = mdao.moimOriginInfo(match_ix);
	int o_length = origlist.size();
	
	//직업마다 색깔 다르게 설정하는 메소드.
	//0에는 글자색, 1에는 배경색 리턴하도로 구현함.
	String m_color[] = mdao.setRoleColor(myMainRole);
	
	if(o_length==0){
		%><tr>
		<td class="pfimg"><img src="<%=mdao.setProfile(member_ix,path) %>" class="pfimg"></td>
		<td class="t1"><%=crt_name %></td>
		<td class="t2" style="color:<%=m_color[0]%>;background:<%=m_color[1]%>;"><%=myMainRole %><br><%=myDetailRole %></td>
		</tr><%
	}else{
	%>
	<tr>
		<td class="pfimg"><img src="<%=mdao.setProfile(member_ix,path) %>" class="pfimg"></td>
		<td class="t1"><%=crt_name %></td>
		<td class="t2" style="color:<%=m_color[0]%>;background:<%=m_color[1]%>;"><%=myMainRole %><br><%=myDetailRole %></td>
	</tr>
		<%
		for(int k=0;k<o_length;k=k+3){
			out.println("<tr>");
			for(int j=0;j<3;j++){
				if(k+j<o_length){
				String o_mainRole = origlist.get(k+j).getogMainRole();
				String o_detailRole = origlist.get(k+j).getogDetailRole();
				String o_cnt = origlist.get(k+j).getmemberNumber();
				
				String o_color[] = mdao.setRoleColor(o_mainRole);
				
			%>
			<td class="pfimg"><img src="/sp/img/profile_default.jpg" class="pfimg"></td>
			<td class="t2" style="color:<%=o_color[0]%>;background:<%=o_color[1]%>;"><%=o_mainRole %><br><%=o_detailRole %></td>
			<td class="t4"><%=o_cnt %>명</td>
			<%
				}
			}
			out.println("</tr>");
		}
	%>
	<%
	}
	%>
	<tr>
		<td class="t3" colspan="9">이 모임에 지원중인 사람</td>
	</tr>
	<%
	ArrayList<MemberDTO> applyList = mdao.moimApplyInfo(match_ix);
	ArrayList<MatchWantedDTO> applyRoleList = mdao.moimApplyRole(match_ix);
	ArrayList<MatchApplyDTO> applyTFlist = mdao.moimApplyIdx(match_ix);
	
	int a_length = applyTFlist.size();
	if(a_length==0){
		%><tr><td colspan="9">모임에 지원한 사람이 없습니다.</td></tr><%
	}else{
		for(int k=0;k<a_length;k++){
			int a_member_ix = applyTFlist.get(k).getMemberIx(); //지원자의 멤버 인덱스
			int a_wanted_ix = applyTFlist.get(k).getMatchWantedIx(); //지원자가 원하는 wanted 인덱스
			int a_apply_ix = applyTFlist.get(k).getMatchApplyIx(); //지원자가 작성한 지원글에 대한 인덱스
			String a_name = applyList.get(k).getMName(); //지원자의 이름
			String a_mainRole = applyRoleList.get(k).getwMainRole(); //지원자가 지원한 메인 역할
			String a_detailRole = applyRoleList.get(k).getwDetailRole(); //지원자가 지원한 세부 역할
			String a_hold = applyTFlist.get(k).getHold(); //지원자가 현재 뽑혔는지 안뽑혔는지 여부(true, false)
			
			String a_color[] = mdao.setRoleColor(a_mainRole); //0번째에 글자색, 1번째에 배경색 리턴해줌
			
			if(a_hold.equals("false")){
				%>
				<tr>
					<td class="pfimg"><img src="<%=mdao.setProfile(a_member_ix,path) %>" class="pfimg"></td>
					<td class="t1"><%=a_name%></td>
					<td class="t2" style="color:<%=a_color[0]%>;background:<%=a_color[1]%>;"><%=a_mainRole %><br><%=a_detailRole %></td>
					<td align="center" colspan="4">
					<form name="makeMoim" action="makeMoimDetail.jsp" method="post">
						<input type="submit" class="btn" value="지원글 상세보기">
						<input type="hidden" name="member_ix" value="<%=a_member_ix%>">
						<input type="hidden" name="match_apply_ix" value="<%=a_apply_ix%>">
					</form>
					</td>
					<td align="center" colspan="2">
						<input class="btn" type="submit" onclick="pick(this,'<%=a_name %>','<%=match_ix %>','<%=a_wanted_ix %>','<%=a_apply_ix %>','<%=a_member_ix %>')" value="모임에 추가하기">
					</td>
				</tr>
				<%
			}
		}
	}
	%>
	<tr>
	<td class="t3" colspan="9">모임에 새로 추가된 사람</td>
	</tr>
	<%
	
	int n_length = applyTFlist.size();
	if(n_length==0){
		%><tr><td colspan="9">모임에 추가된 사람이 없습니다.</td></tr><%
	}else{
		for(int k=0;k<a_length;k++){
			int a_member_ix = applyList.get(k).getMemberIx(); //지원자의 멤버 인덱스
			int a_wanted_ix = applyRoleList.get(k).getmatchWantedIx(); //지원자가 원하는 wanted 인덱스
			int a_apply_ix = applyTFlist.get(k).getMatchApplyIx(); //지원자가 작성한 지원글에 대한 인덱스
			String a_name = applyList.get(k).getMName(); //지원자의 이름
			String a_mainRole = applyRoleList.get(k).getwMainRole(); //지원자가 지원한 메인 역할
			String a_detailRole = applyRoleList.get(k).getwDetailRole(); //지원자가 지원한 세부 역할
			String a_hold = applyTFlist.get(k).getHold(); //지원자가 현재 뽑혔는지 안뽑혔는지 여부(true, false)
			
			String a_color[] = mdao.setRoleColor(a_mainRole); //0번째에 글자색, 1번째에 배경색 리턴해줌
			
			if(a_hold.equals("true")){
				%>
				
				<tr>
					<td class="pfimg"><img src="<%=mdao.setProfile(a_member_ix,path) %>" class="pfimg"></td>
					<td class="t1"><%=a_name%></td>
					<td class="t2" style="color:<%=a_color[0]%>;background:<%=a_color[1]%>;"><%=a_mainRole %><br><%=a_detailRole %></td>
					<td align="center" colspan="4">
					<form name="makeMoim" action="/sp/humansearch/humanSelect.jsp" method="post"><!-- 프로필 확인하러 가는 부분 -->
						<input type="submit" class="btn" value="프로필 보러가기">
						<input type="hidden" name="member_ix" value="<%=a_member_ix%>">
					</form>
					</td>
					<td align="center" colspan="2">
						<span style="font-size:15px;font-weight: bold;color: green;">승인 완료</span>
					</td>
				</tr>
			<%
			}
		}
	}
	%>
	<tr>
		<td align="right" colspan="9">
		<input type="button" value="수정하기" class="btn" onclick="javascript:location.href='/sp/mypage/makeMoimCardModify.jsp?ix=<%=comp_ix%>&mix=<%=match_ix%>'">
		<input type="button" value="삭제하기" class="btn" onclick="deleteApply('<%=match_ix%>')">
		</td>
	</tr>
</table>