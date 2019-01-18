<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="member.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

<jsp:useBean id="mdao" class="member.MemberDAO"></jsp:useBean>
<%
//idEmail,pwd 가져오기
String idEmail = request.getParameter("idEmail");
String pwd = request.getParameter("pwd");
String saveidEmail = request.getParameter("rememberidEmail");
//idEmail, pwd 있는지, 있다면 옳은지 판단
boolean membercheck = false;
if(idEmail!=null && pwd!=null){
	membercheck = mdao.ChceckidEmailPwd(idEmail, pwd);
}
%>


<%
	if(membercheck){
		String mname = mdao.getMemberName(idEmail);
		session.setAttribute("sidEmail", idEmail);
		session.setAttribute("smname", mname);

		idEmail = URLEncoder.encode(idEmail);
		Cookie ck = new Cookie("saveidEmail",idEmail);
		if(saveidEmail==null||saveidEmail.equals("")){
			ck.setMaxAge(0);
		}else{
			ck.setMaxAge(Integer.MAX_VALUE);
		}
		response.addCookie(ck);
	%>
		<script>
		alert('<%=mname%>님,\n어서오세요! 환영합니다!');
		location.href = 'index.jsp';
		</script>
	<%
	} else{
	%>
		<script>
		alert("오류입니다.");
		location.href = 'login.jsp';
		</script>
	<%
    }
%>
	
