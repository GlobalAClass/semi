<%@page import="java.util.ArrayList"%>
<%@page import="java.nio.charset.Charset"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="db.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="member.MemberDTO" %>
<%@ page import="member.MemberDetailDTO" %>
<%@ page import="member.MemberHistoryDTO" %>
<%@ page import="member.MemberDAO" %>

<%
	request.setCharacterEncoding("UTF-8"); //포스트 전송때, 한글깨짐 막기위해 세팅. - 서버에 get방식은 설정되어있음.
	int addCount = Integer.parseInt(request.getParameter("addCount")); //공모전 이력 개수.
	//공모전 이력 개수에 맞추어 memberHistoryDTO 생성. -> DB에 넣으로면 회원 index필요하므로 회원먼저 처리 후에 등록.
	ArrayList<MemberHistoryDTO> mhdto = new ArrayList<MemberHistoryDTO>();
	for(int i = 0;i<addCount; i++){
		String cName = request.getParameter("cName"+i);
		String period = request.getParameter("period"+i);
		String mainRole = request.getParameter("mainRole"+i);
		String detailRole = request.getParameter("detailRole"+i);
		String award = request.getParameter("award"+i);
		String detail = request.getParameter("detail"+i);
		mhdto.add(new MemberHistoryDTO(cName, period, mainRole, detailRole, award, detail));
	}
	
	
%>

<jsp:useBean id="mdto" class="member.MemberDTO"/> <!-- 회원 필수 사항 -->
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mddto" class="member.MemberDetailDTO"/> <!-- 회원 추가 사항 -->
<jsp:setProperty property="*" name="mddto"/>
<jsp:useBean id="mdao" class="member.MemberDAO"/>

<script>
alert('<%=mddto.getBirthYear()%>');
alert('<%=mddto.getContactAgreement()%>');
alert('<%=mddto.getKakaoIdAgreement()%>');
</script>

