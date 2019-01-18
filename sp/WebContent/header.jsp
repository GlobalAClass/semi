<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<%
String[] sn = session.getValueNames();
String mname = null;
for(int i = 0 ; i<sn.length; i++){
        if(sn[i].equals("smname")){
                mname = (String)session.getValue(sn[i]);
        } else if(sn[i].equals("sidEmail")){
                String id = (String)session.getValue(sn[i]);
        }
}
if(mname==null){
%>
	<div>
		<a href="/sp">HOME |</a>
		<a href="/sp/login.jsp">로그인 |</a>
		<a href="/sp/memberJoin/memberJoin.jsp">회원가입</a>
	</div>
<%
} else {
%>
	<div>
		<a href="/sp">HOME |</a>
		<a><%=mname %>님은 공모전 준비중~ |</a>
		<a href="/sp/logout.jsp">로그아웃</a>
	</div>
<%
}
%>
	<p><img src="/sp/img/Yes.jpg"></p> 
	<nav>
		<ul>
			<li><a href="/sp/Competition/Competition.jsp">공모전 정보</a></li>
			<li><a href="/sp/moimsearch/moimSearch.jsp">모임 검색</a></li>
			<li><a href="/sp/humansearch/humanSearch.jsp">사람 검색</a></li>
		</ul>
	</nav>
	<hr>
</header>