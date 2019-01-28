<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="member.*"%>
<%@page import="match.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<jsp:useBean id="memdao" class="member.MemberDAO"/>
<jsp:useBean id="mddao" class="member.MemberDetailDAO"/>
<jsp:useBean id="mhdao" class="member.MemberHistoryDAO"/>
<jsp:useBean id="matdao" class="match.MatchDAO"/>
<jsp:useBean id="ogdao" class="match.MatchOriginalDAO"/>
<jsp:useBean id="apdao" class="match.MatchApplyDAO"/>

<style>
#group_name{
	width:800px;
	height:auto;
}
.group_info{
	width:800px;
	height: auto;
	margin-top: 0px
}
.group_all{
	width:800px;
	height: auto;
	margin:0px;
	padding:5px;
}
.group_2{
	margin-top:10px;
	width: 600px;
	height: auto;
}
.group_2 th{
	width: 150px;
	background: #D8D8D8;
}
.group{
	width: 800px;
	height: auto;
	border-bottom: 1px solid black;
	text-align: center;
}
.group_people{
	width: 65px;
	height: 70px;
}
.group_img{
	width: 20px;
	height: 15px;
	padding-right: 5px;
}
</style>
<script type="text/javascript">
//next, previous 공부하느라 코드가 길어짐, id를 이용하는 것이 편함.
//상세목록 접고 펼치는 함수.
function fold(obj){
	obj.parentNode.parentNode.style.display = "none";
	obj.parentNode.parentNode.previousSibling.previousSibling.style.display = "block";
}
function expand(obj){
	obj.nextSibling.nextSibling.style.display = "block";
	obj.style.display = "none";
}
</script>
<%!
	//
	public String manageNull(String str) {
		if (str == null || str.equals("")) {
			return "";
		} else {
			return str;
		}
	}

	public String manageNull2(String str) {
		if (str == null || str.equals("")) {
			return "없음";
		} else {
			return str;
		}
}
%>
<%	
	//로그인해야 해당 페이지를 이용할 수 있음.
	String uname = (String)session.getAttribute("smname");
	String uid = (String)session.getAttribute("sidEmail");
	
	if(uname == null || uname.equals("") || uid==null || uid.equals("")){
		%>
		<script>
			alert("로그인하셔야 이용하실 수 있습니다.");
			location.href="/sp/login.jsp";
		</script>
		<%
		return ;
	}
	
	//모임글 정보 가져오기.
	int match_ix = Integer.parseInt(request.getParameter("mix"));
	MatchDTO matchdto= matdao.getMoimCard(match_ix);
	
	int member_ix = matchdto.getMemberIx();
	//현재 로그인한 유저가 모임장과 일치하는지 체크
	boolean jangcheck =false;
	int usermem_ix = memdao.getMemberIndex(uid);
	if(usermem_ix == member_ix){
		jangcheck = true;
	}
	//모임장의 필수 사항
	MemberDTO memdto = memdao.getMemberInfo(member_ix);
	//모임장의 추가 사항
	MemberDetailDTO mddto = mddao.getMemberDetailInfo(member_ix);
	//모임장의 공모전 이력 사항
	ArrayList<MemberHistoryDTO> mhdto = mhdao.getMemberHistoryInfo(member_ix);
	
	//출력될 프로필 가져오기.
	File userdir = new File(request.getServletContext().getRealPath("\\")+ "\\img\\profile\\"+member_ix);
	File[] files = userdir.listFiles();
	String imagpath;
	if(files.length>0){
		imagpath = "/sp/img/profile/"+member_ix+"/"+files[0].getName();
	}else{
		imagpath = "/sp/img/profile_default.jpg";
	}
	
	//출력할 값 중 null값이 있는지 확인.
	String birthyear = manageNull(mddto.getBirthYear());
	String kakaoid = manageNull(mddto.getKakaoId());
	String contact = manageNull(mddto.getContact());
	
	//KAKAOID, CONTACT 공개여부 확인
	if(mddto.getKakaoIdAgreement().equals("false")){
		kakaoid = "비공개";
	}
	if(mddto.getContactAgreement().equals("false")){
		contact= "비공개";
	}
	
%>
<div id="group_name">
	<div class="group_info">
		<br>
		<h3 style="font-size: 35px;"><%=matchdto.getMatchName() %></h3>
		<p style="float:right;"><%=matchdto.getWriteDate() %></p>
		<br>
		<h4 style="float:left;">모임장 소개글</h4>
	</div>
	<div class="group_all">
		<table style="width: 800px;height: auto;">
			<tr>
				<td rowspan="4"><img style="width:90px;height:100px;" src="<%=imagpath%>"></td>
				<td style="font-size:19px;"><%=memdto.getMName() %></td>
				<td style="font-size:12px;color:gray;"><%=birthyear %>년생</td>
				<td><%=memdto.getFieldMajor() %></td>
			</tr>
			<tr>	
				<td colspan="4" style="font-size:19px"><%=matchdto.getMainRole() %>, <%=matchdto.getDetailRole() %></td>
			</tr>
			<tr>
				<td colspan="2"><img src="/sp/img/mail.png" class="group_img"><%=memdto.getidEmail() %></td>
				<td><img src="/sp/img/talk.png" class="group_img"><%=kakaoid %></td>
				<td><img src="/sp/img/phone.jpg" class="group_img"><%=contact %></td>
			</tr>
			<tr>		
				<td>공모전 경력</td>
				<%
				int length=0;
				if(mhdto.size()>0){
					length = mhdto.size();
				}
				if(length>0){ %>
				<td colspan="2" style="color:green;font-size:15px;">있음</td>
				<%}else{ %>
				<td colspan="2" style="color:red;font-size:15px;">없음</td>
				<%} %>
			</tr>
		</table>
		
	<div class="group" style="border-bottom: none;">
	<input type="button" value="상세목록 열기" onclick="expand(this);" style="display: none; height: 35px; margin-right: 0; margin-left: auto;">
	<fieldset>
	<legend style="text-align: right; margin-bottom: 10px;"><input type="button" value="상세목록 접기" onclick="fold(this);" style="height: 35px;"></legend>
		<%
		for(int t=0; t<length;t++){ 
				String mainrole = manageNull(mhdto.get(t).getMainRole());
				String detailrole = manageNull(mhdto.get(t).getDetailRole());
				String award = manageNull(mhdto.get(t).getAward());
				String detail = manageNull(mhdto.get(t).getDetail());
		%>
		<table border="1" class="group_2" cellspacing="0">
			<tr>
				<th>공모전 이름</th>
				<td><%=mhdto.get(t).getCName() %></td>
			</tr>
			<tr>
				<th>공모전 기간</th>
				<td><%=mhdto.get(t).getPeriod() %></td>
			</tr>
			<tr>
				<th>담당 역할</th>
				<td><%=mainrole+", "+detailrole %></td>
			</tr>
			<tr>
				<th>수상 내역</th>
				<td><%=award %></td>
			</tr>
			<tr>
				<th>상세 내용</th>
				<td><pre><%=detail %></pre></td>
			</tr>
		</table>
		<%
		} 
		%>
		<h4>현재 모임에 속해있는 사람</h4>
		<%
		ArrayList<MatchOriginalDTO> ogdto=ogdao.getogMemberInfo(match_ix);
		int l = ogdto.size();
		for(int j=0;j<l;j+=2){
		%>
		<table style="width:650px;">
			<tr>
				<td><img class="group_people" src="/sp/img/profile_default.jpg"></td>
				<td>
					<ul style="list-style-type:none;">
						<li><%=ogdto.get(j).getogMainRole()+"-"+ogdto.get(j).getogDetailRole() %></li>
						<li><%=ogdto.get(j).getmemberNumber() %>명</li>
					</ul>
				</td>
				<%if(j+1<l){ %>
				<td><img class="group_people" src="/sp/img/profile_default.jpg"></td>
				<td>
					<ul style="list-style-type:none;">
						<li><%=ogdto.get(j+1).getogMainRole()+"-"+ogdto.get(j+1).getogDetailRole() %></li>
						<li><%=ogdto.get(j+1).getmemberNumber()%>명</li>
					</ul>
				</td>
				<%} %>
			</tr>
		</table>
		<%} %>
	</fieldset>
	</div>
	<div class="group">
		<h4>이런 지역/요일에 모임을 가지고 싶어요</h4>
		<ul style="list-style-type:none;">
			<li><%=matchdto.getSido() %> <%=matchdto.getSigungu() %></li>
			<li>주 <%=matchdto.getTimesAWeek() %></li>
			<li><%=matchdto.getDay() %></li>
		</ul>
	</div>
	<%
		//null 들어갈 수 있는 항목 처리.
		String et = manageNull(matchdto.getEquipTech());
		String dt = manageNull(matchdto.getDetail());
	%>
	<div class="group">
			<h4>이런 기술/장비를 이용하고 싶어요</h4>
			<ul style="list-style-type:none;">
				<li><pre><%=et %></pre></li>
			</ul>
		</div>
		<div class="group">
			<h4>공모전 모임 상세소개</h4>
			<p><pre><%=dt %></pre></p>
		</div>
		<div class="group" style="margin-bottom: 10px;">
			<h4>이런 사람을 구하고 있어요</h4>
			<%
			String Agert = matchdto.getAgeRestriction();
			if(Agert.equals("무관")){
				Agert = "상관없어요.";
			}else{
				Agert += "세 이하면 좋겠어요.";
			}
			%>
			<p>나이는 <%=Agert %></p>
			<%if(jangcheck){ %>
			<p style="text-align: right;"><button style="color:red;" type="button" onclick="javascript:location.href='/sp/mypage/makeMoim.jsp'">모집인원<br>보러가기</button></p></td>
			<%} %>
			<table style="width:700px; margin: 5px auto;">
				<thead>
					<tr>
						<th><p style="color: white;">이미지<p></th>
						<th>역할</th>
						<th>인원</th>
						<th>필요 능력</th>
						<%if(jangcheck){ %>
						<th>모집인원 이름</th>
						<%}else{ %>
						<th>지원</th>
						<%} %>
					</tr>
				</thead>
			<%
			ArrayList<MatchWantedDTO> mwdto = mwdao.MatchAddPeople(match_ix);
			int li = mwdto.size();
			
			//모임글에 모집되었을 경우(), 다른 역할 지원 버튼 안 뜨게 하기 위한 코드.
			//모집된 역할은 rememberNumber에 저장.
			boolean recruited_check = false;
			int rememberNumber = -1;
			for(int i=0; i<li;i++){
				//현재 로그인한 유저가 지원자인지 체크
				int match_wanted_ix = mwdto.get(i).getmatchWantedIx();
				boolean jicheck = apdao.areYouApply(match_wanted_ix, usermem_ix);
				//현재 로그인한 유저가 지원자라면 모집됬는지 체크
				if(jicheck){
					recruited_check = memdao.areYouRecruitedMember(match_ix, match_wanted_ix, usermem_ix);
					if(recruited_check){
						rememberNumber = i;
					}
				}
			}
			
			for(int i=0; i<li; i++){
				//필요능력사항 null체크
				String ra = manageNull2(mwdto.get(i).getRequiredAbility());
				//현재 로그인한 유저가 지원자인지 체크
				int match_wanted_ix = mwdto.get(i).getmatchWantedIx();
				boolean jicheck = apdao.areYouApply(match_wanted_ix, usermem_ix);
			%>
				<tr>
					<td width="150px"><img class="group_people" src="/sp/img/profile_default.jpg"></td>
					<td width="150px">
						<%=mwdto.get(i).getwMainRole() %><br><%=mwdto.get(i).getwDetailRole() %>
					</td>
					<td>
						<%=mwdto.get(i).getRecruitedNumber() %>/<%=mwdto.get(i).getWantedNumber() %>명
					</td>
					<td width=150px;>
						<pre><%=mwdto.get(i).getRequiredAbility() %></pre>
					</td>
					<td width="150px;">
					<%
					if(jangcheck){ 
						//뽑은 인원들의 이름 구하기.
						ArrayList<String> names = memdao.getRecruitedMemberName(match_ix, match_wanted_ix);
						if(names==null || names.size() <1){
						%>
							<p>모집인원 없음</p>	
						<%
						}else{
							for(int j=0; j<names.size();j++){
							%>
								<p><%=names.get(j) %></p>
							<%
							}
						}
					%>
						<p>&nbsp;&nbsp;&nbsp;</p></td>
					<%
					}else if(i==rememberNumber){ 
					%>
						<p style="color : red;">축하드립니다.<br>지원서 통과!</p></td>
					
					<%
					}else if(!mwdto.get(i).getRecruitedNumber().equals(mwdto.get(i).getWantedNumber())){ 
						//모집은 안 됐고 지원은 한 경우.
						if(jicheck && !recruited_check){
						%>
						<p style="color : green;">지원완료<br>지원서 검토중</p></td>
						<%
						//모집이 되면 모집하기 버튼 없음.
						}else if(!recruited_check){ 
						%>
						<input style="width:70px;height:40px;background:#58ACFA;color:white;" type="button" value="지원하기" 
							onclick="javascript:location.href='CompetitionMoimApply.jsp?ix=<%=request.getParameter("ix") %>&mix=<%=match_ix%>&mwix=<%=mwdto.get(i).getmatchWantedIx()%>'"></td>
						<%}
					}else{ 
					%>
						<p style="color : red;">모집종료</p></td>
					<%
					}
					%>
				</tr>
			<%} %>
			</table>
		</div>
	</div>
</div>