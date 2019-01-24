<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
h2{
	background: #424242;
	color: white;
	padding: 9px;
	text-align: center;
}    
aside, article{
	float: left;
}
aside{
	width: 200px;
}
aside a{
	vertical-align:middle;
	text-decoration:underline;
	color: black;
	font-weight: bold;
}
.p_style{
	font-size: 20px;
	font-weight: bold;
}
</style>
<aside>
	<h2>마이페이지</h2>
	<nav>
	<p class="p_style"><a href="/sp/mypage/myProfile.jsp">프로필 수정하기</a></p>
	<p class="p_style">나의 모임</p>
		<ul>
		<li><a href="/sp/mypage/makeMoim.jsp">내가 만든 모임</a></li>
		<li><a href="/sp/mypage/recruitMoim.jsp">내가 지원한 모임</a></li>
		</ul>
	<p class="p_style"><b>스크랩</b></p>
		<ul>
		<li>공모전</li>
		<li><a href="/sp/mypage/myScrapHuman.jsp">사람</a></li>
		</ul>
	</nav>
</aside>