<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="applydto" class="match.MatchApplyDTO"/>
<jsp:setProperty property="*" name="applydto"/>
<jsp:useBean id="applydao" class="match.MatchApplyDAO"/>
<%
//신청한 자신 인덱스 
int memberIx = Integer.parseInt(request.getParameter("memberIx"));
//신청한 글에 대한 인덱스
int matchIx = Integer.parseInt(request.getParameter("matchIx"));
//신청한 역할에 대한 인덱스
int matchWantedIx = Integer.parseInt(request.getParameter("matchWantedIx"));
//자기소개 내용
String aboutApplicant = request.getParameter("aboutApplicant");
//다른공모전 or 플젝 참여 여부
String otherExC = request.getParameter("otherExC");

int cnt = applydao.matchApplyInsert(applydto);

String msg=cnt>0?"모임에 지원되었습니다. 마이페이지에서 확인하시겠습니까?":"모임 지원 오류";

//지원 시행 후 돌아갈 인덱스
int ix = Integer.parseInt(request.getParameter("ix"));

%>
<script>
var res = confirm('<%=msg%>');

if(res){
	location.href='/sp/mypage/recruitMoim.jsp';
}else{
	location.href='/sp/Competition/CompetitionDetail.jsp?ix='+<%=ix%>;
}

</script>