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
</style>
<aside>
	<h2>마이페이지</h2>
	<nav>
	<p><a href="/sp/mypage/myProfile.jsp">프로필 수정하기</a></p>
	<p>나의 모임</p>
		<ul>
		<li><a href="/sp/mypage/makeMoim.jsp">내가 만든 모임</a></li>
		<li><a href="/sp/mypage/recruitMoim.jsp">내가 지원한 모임</a></li>
		</ul>
	<p>스크랩</p>
		<ul>
		<li>공모전</li>
		<li>사람</li>
		</ul>
	</nav>
</aside>