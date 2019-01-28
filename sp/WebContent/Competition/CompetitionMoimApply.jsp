
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="member.*" %>
<%@page import="match.*" %>

<jsp:useBean id="memberdao" class="member.MemberDAO"/>
<jsp:useBean id="mdetaildao" class="member.MemberDetailDAO"/>
<jsp:useBean id="mhistorydao" class="member.MemberHistoryDAO"/>

<%
//로그인한 해당 사람의 인덱스
String idEmail = (String)session.getAttribute("sidEmail");
int member_ix = memberdao.getMemberIndex(idEmail);
//해당 모임글에 대한 index
int match_ix = Integer.parseInt(request.getParameter("mix"));
//매칭 원하는 사람에 대한 index
int match_wanted_ix = Integer.parseInt(request.getParameter("mwix"));
//모임 지원 후 되돌아갈 idx
int ix = Integer.parseInt(request.getParameter("ix"));
%>

<%!
	//null값 처리
	public String manageNull(String str) {
		if (str == null || str.equals("")) {
			return "";
		} else {
			return str;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
article{
	width:800px;
	margin-left:200px;
}
.bodytype2{
	width: 800px;
	padding-top: 20px;
	padding-left: 20px;
	padding-right: 20px;
}
.bodytype{
	width: 800px;
	border-bottom: 0.5px solid black;
	padding: 20px;
}
.btn{
	width: 150px;
	height: 50px;
	font-size: 20px;
	margin: 20px;
}
#pfimg{
	width:80px;
	height:80px;
	padding:2px;
}
#header{
	width: 800px;
	border: 0.5px dotted gray;
}
.header_info{
	width: 100%;
	overflow: hidden;
	position: relative;
}
.header_group_people{
	width: 60px;
	height: 60px;
	padding-left: 60px;
}
.msgImg{
	width: 20px;
	padding-right: 5px;
}
ul{
	list-style: none;
}
</style>
<script type="text/javascript">

//submit 전에 유효성 검사
function formCheck(){
	if(CompetitionMoimApply.aboutApplicant.value ==""){
		alert("자기소개를 입력해주세요.");
		CompetitionMoimApply.aboutApplicant.focus();
		return false;
	}else if (CompetitionMoimApply.otherExC.value == ""){
		alert("현재 다른 공모전 참여 여부를 선택해주세요.");
		//CompetitionMoimApply.otherExC.focus();
		return false;
	}

	return true;
	
}
</script>
</head>
<body>
<%@include file="/header.jsp"%>
<section>
	<article>
	<div class="bodytype" align="center">
<!-- 산청글로부터 정보를 받아서 뿌려야 하는 부분 -->
<%
MatchApplyDAO madao = new MatchApplyDAO();

//모임글 작성자에 대한 정보 가져오는 메소드들
MemberDTO moimdto = madao.writeInfo(match_ix);
MemberDetailDTO moimdetaildto = madao.writeDetailInfo(match_ix);
//해당 모임글에 대한 정보 가져오는 메소드들
MatchDTO matchdto = madao.matchInfo(match_ix);
ArrayList<MatchOriginalDTO> matchoglist = madao.matchOriginalInfo(match_ix);

//현재 글쓴 모임장의 정보들
String m_name = moimdto.getMName();
String m_year = manageNull(moimdetaildto.getBirthYear());
String m_fieldmajor = moimdto.getFieldMajor();
String m_role = matchdto.getMainRole() +" - "+ matchdto.getDetailRole();
String m_email = moimdto.getidEmail();
String m_kakaoid = manageNull(moimdetaildto.getKakaoId());
String m_tell = manageNull(moimdetaildto.getContact());

%>
	<div style="font-size:40px;font-weight: bold;margin-bottom:10px;">신청하려는 모임의 정보</div>
	<div id="header"align="center">
		<h2 style="font-size:20px;margin:10px;">모임장 소개</h2>
			<table style="width: 750px;padding-bottom:20px;">
				<tr>
					<td rowspan="4"><img style="width:100px;height:100px;" src="/sp/img/profile_default.jpg"></td>
					<td style="font-size:25px;font-weight: bold;"><%=m_name %></td>
					<td style="font-size:12px;color:gray;"><%=m_year %>년생</td>
					<td colspan="2" style="font-size:16px;"><%=m_fieldmajor %></td>
				</tr>
				<tr>	
					<td colspan="4" style="font-size:16px"><%=m_role %></td>
				</tr>
				<tr>
					<td colspan="2"><img src="/sp/img/mail.png" class="msgImg"><%=m_email %></td>
					<td><img src="/sp/img/kakao.jpg" class="msgImg"><%=m_kakaoid %></td>
					<td><img src="/sp/img/tell.jpg" class="msgImg"><%=m_tell %></td>
				</tr>
			</table>
			<hr style="border:0.5px gray dotted">
		<h4 style="font-size:20px;">현재 모임에 속해있는 사람</h4>
		<table style="padding-bottom:20px;">
			<%
			//현재 모임에 참여하고있는 사람들의 정보 가져오기
			int length = matchoglist.size();

			if(length==0){
				%>
				<tr>
					<td>모임에 참여한 인원이 없습니다.</td>
				</tr>
				<%
			}else{
				for(int j=0;j<length/2+1;j++) //인원수 증가할 때 tr 생성
					%><tr><%
					for(int i=0;i<length;i++){
						String o_role = matchoglist.get(i).getogMainRole()+" - "+matchoglist.get(i).getogDetailRole();
						String o_num = matchoglist.get(i).getmemberNumber();
					%>
						<td style="width:140px;"><img class="header_group_people" src="/sp/img/profile_default.jpg"></td>
						<td style="width:200px;">
							<ul style="padding:8px;list-style: none;">
								<li><b><%=o_role %></b></li>
								<li><%=o_num %>명</li>
							</ul>
						</td>
					<%
					}
					%><tr><%
			}
			%>
		</table>
		<hr style="border:0.5px gray dotted">
<!-- 참여한 모임에 대한 정보 가져오는 -->
<%
String location = matchdto.getSido()+" "+manageNull(matchdto.getSigungu());
String times = matchdto.getTimesAWeek();
String day = matchdto.getDay();
%>
		<div>
			<h4 style="font-size:20px;">이런 지역/요일에 모임을 가지고 싶어요</h4>
			<ul>
				<li style="font-size:17px;color:darkblue;"><%=location %></li>
				<li style="font-size:15px;color:darkgreen;">주 <%=times %></li>
				<li style="font-size:15px;color:darkgreen;"><%=day %></li>
			</ul>
		</div>
	</div>
<!-- 신청자 본인 정보 db에서 받아와서 뿌려주는 부분 -->
<%

//모임 지원하는 회원의 정보 모두 얻어오기
MemberDTO memberdto = memberdao.getMemberInfo(member_ix);
MemberDetailDTO mdetaildto = mdetaildao.getMemberDetailInfo(member_ix);
ArrayList<MemberHistoryDTO> complist = mhistorydao.getMemberHistoryInfo(member_ix);
int listLength=0;
if(complist==null){
	listLength=0;
}else{
	listLength=complist.size(); //리스트 갯수
}

//본인의 전공과 생년
String fieldmajor = memberdto.getFieldMajor();
String birthyear = manageNull(mdetaildto.getBirthYear());

//모임글 페이지에서 지원하려고 선택한 역할
MatchWantedDTO mwdto = madao.matchWantedInfo(match_wanted_ix);
String r_role = mwdto.getwMainRole()+" - "+mwdto.getwDetailRole();
//모임글에서 요구한 필요 능력 사항
String r_ability = mwdto.getRequiredAbility();
if(r_ability==null || r_ability.equals("")){
	r_ability = "없음";
}

%>
	</div>
			<div class="bodytype" align="center">
			<div align="center" style="margin:20px;font-size:30px; font-weight: bold;">내가 지원한 역할</div>
			<table style="font-size:23px;text-align:left;">
				<tr>
					<th style="width:200px;heignt:30px;">담당 역할 </th>
					<td style="color: #8A0808;"><%=r_role%></td>
				</tr>
				<tr>
					<th style="heignt:30px;">필요 능력 사항 </th>
					<td style="color: #8A0808;"><%=r_ability %></td>
				</tr>
			</table>
			</div>
			<div class="bodytype2" align="center">
			<div align="center" style="margin:20px;font-size:35px; font-weight: bold;">자기소개서 작성</div>
			<table style="width:600px;height:200px;text-align:left;">
				<tr>
					<td rowspan="3" style="width:120px;padding-left:20px;"><img src="/sp/img/profile_default.jpg" id="pfimg">
					<input style="width:100px; height:20px; font-size:12px;" type="button" value="프로필 수정하기" onclick="javascript:location.href='/sp/mypage/myProfile.jsp'">
					</td>
					<th>분야/전공</th>
					<td><input style="height:25px;" type="text" name="field" readonly="readonly" value="<%=fieldmajor %>"></td>
				</tr>
				<tr>
					
					<th>출생년도</th>
					<td><input style="height:25px;" type="text" name="birthYear" readonly="readonly" value="<%=birthyear %>"></td>
				</tr>
				<tr>
					
					<th>공모전 경력 여부</th>
					<td>
						<%if(listLength>0){out.print("있음");}else{out.print("없음");} %>
					</td>
				</tr>
			</table>
		</div>
		<div class="bodytype" align="center">
			<p style="text-align:right;">
				<input type="button" value="공모전 내역 수정하기" onclick="javascript:location.href='/sp/mypage/myProfile.jsp'">
			</p>
			<%
			for(int i=0;i<listLength;i++){
				String compName = manageNull(complist.get(i).getCName());
				String compPeriod = manageNull(complist.get(i).getPeriod());
				String compAward = manageNull(complist.get(i).getAward());
				String compMainrole = manageNull(complist.get(i).getMainRole());
				String compDetailrole = manageNull(complist.get(i).getDetailRole());
				String compDetail = manageNull(complist.get(i).getDetail());
			%>
			<table border="1" cellspacing="0" style="width:700px;height:240px;margin-bottom:20px;">
				<tr>
					<th style="width:150px;height:25px;">공모전 이름</th>
					<td style="width:550px;height:25px;" colspan="3"><%=compName %></td>
				</tr>
				<tr>
					<th>공모전 기간</th>
					<td style="width:550px;height:25px;" colspan="3"><%=compPeriod %></td>
				</tr>
				<tr>
					<th>수상 내역</th>
					<td><%=compAward%></td>
					<th style="width:150px;height:25px;">담당 역할</th>
					<td><%=compMainrole+" - "+compDetailrole %></td>
				</tr>
				<tr>
					<th rowspan="3">상세 내용</th>
					<td rowspan="3" colspan="3"><pre><%=compDetail %></pre></td>
				</tr>
			</table>
			<%
			}
			%>
		</div>
<!-- 매칭 지원 시 필요한 자기소개서 작성 부분 -->
	<form name="CompetitionMoimApply" action="CompetitionMoimApply_ok.jsp" onsubmit="return formCheck()" method="post">
		<div class="bodytype2">
			<div style="font-size:25px;font-weight:bold;margin-bottom:15px;">자기소개</div>
			<textarea name="aboutApplicant" style="width:800px; height: 150px;" placeholder="프로젝트 경험 또는 다룰 수 있는 기술에 대해 설명해주세요."></textarea>
		</div>
		<div class="bodytype2" align="center">
			<div style="font-size:25px;font-weight: bold;">현재 또 다른 공모전이나 프로젝트에 참여하고 있으신가요?</div>
		<p>
			<input type="radio" name="otherExC" value="true">네
			<input type="radio" name="otherExC" value="false">아니오
		</p>
		<div style="text-align:center;">
			<input class="btn" type="submit" value="모임 지원하기">
			<input class="btn" type="button" onclick="" value="취소">
		</div>	
		</div>
		<input type="hidden" name="memberIx" value="<%=member_ix%>">
		<input type="hidden" name="matchIx" value="<%=match_ix%>">
		<input type="hidden" name="matchWantedIx" value="<%=match_wanted_ix%>">
		<input type="hidden" name="ix" value="<%=ix%>">
	</form>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>