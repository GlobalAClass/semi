<%@ page import="member.*"%>
<%@ page import="match.*"%>
<%@ page import="mypage.MyRecruitMoimDAO"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
//본인 인덱스 가져오는 메소드
String crt_id = (String)session.getAttribute("sidEmail");
MemberDAO dao = new MemberDAO();
int member_ix=dao.getMemberIndex(crt_id);
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
	margin-left:100px;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/mypage/aside.jsp" %>
<section>
<article>
	<div align="center" style="font-size:40px;font-weight:bold;margin:30px;">내가 지원한 모임</div>
	<%
	MyRecruitMoimDAO rdao = new MyRecruitMoimDAO();
	
	ArrayList<MemberDTO> mlist = rdao.recruitMoimMakeName(member_ix);
	ArrayList<MatchDTO> malist = rdao.recruitMoimName(member_ix);
	ArrayList<MatchWantedDTO> mwlist = rdao.recruitWanted(member_ix);
	String compName[] = rdao.recruitCompName(member_ix);
	int applylist[] = rdao.recruitApplyidx(member_ix);
	
	int length=compName.length;
	if(length==0){
		%><div align="center" style="font-size:20px;font-weight:bold;margin:20px;">지원한 모임이 존재하지 않습니다.</div><%
	}else{
		for(int i=0;i<length;i++){
			int m_ix = mlist.get(i).getMemberIx(); //모임 개설한 사람의 idx - 프로필사진 연결에 사용
			int match_ix = malist.get(i).getMatchIx(); //해당 모임글에 대한 idx
			int match_wanted_ix = mwlist.get(i).getmatchWantedIx(); //신청한 역할에 대한 idx
			String makerName = mlist.get(i).getMName(); //해당 모임을 만든 멤버의 이름
			String state = malist.get(i).getCompletedState(); //해당 모임이 현재 진행중인지에 대한 상태값
			String moimName = malist.get(i).getMatchName(); //해당 모임에 대한 모임이름
			String myrole= mwlist.get(i).getwMainRole()+" - "+mwlist.get(i).getwDetailRole(); //모임 지원시 선택한 역할
			
	%>
		<%@include file="/mypage/recruitMoimCard.jsp" %>
	<%
		}
	}
	%>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>