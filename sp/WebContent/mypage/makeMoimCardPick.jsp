<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="match.*" %>

<%
request.setCharacterEncoding("utf-8");

int match_ix = Integer.parseInt(request.getParameter("mix"));
int match_wanted_ix = Integer.parseInt(request.getParameter("wix"));
int match_apply_ix = Integer.parseInt(request.getParameter("aix"));
int member_ix = Integer.parseInt(request.getParameter("ix"));

MatchRecruitedDAO mdao = new MatchRecruitedDAO();

//wanted 테이블에 추가하기
int res = mdao.applyPick(match_ix, match_wanted_ix, match_apply_ix, member_ix);

//테이블에 추가 되었으면
if(res>0){
	//original 테이블 항목의 해당 역할 모집된 인원 수 1 더해주기
	int cnt1 = mdao.originUpdate(match_wanted_ix);
	//apply 테이블의 모집 여부 true로 변환해주기
	int cnt2 = mdao.applyHoldChange(match_apply_ix);
	
	System.out.println(cnt1+"/"+cnt2);
}

String msg = (res>0)?"팀원이 추가되었습니다.":"오류남";
System.out.println(res);
%>
<script>
alert('<%=msg%>');
location.href='/sp/mypage/makeMoim.jsp';
</script>