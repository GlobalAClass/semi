<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
table{
	border: gray 1px solid;
	padding: 10px;
	width:700px;
}
.pfimg{
	width:50px;
	height:50px;
	padding:2px;
}
.btn{
	width:170px;
	height:40px;
	background: lightgray;
	font-size:15px;
	font-weight: bold;
}
</style>
<section>
<article>
<table>
	<tr>
		<td align="right" colspan="4">모집 진행중</td>
	</tr>
	<tr>
		<td class="pfimg" rowspan="2"><img src="/sp/img/profile.jpg" class="pfimg"></td>
		<td style="font-size:20px;font-weight:bold;" colspan="3">공모전 명</td>
	</tr>
	<tr>
		<td colspan="3">모임명 | 모임 주최자</td>
	</tr>
	<tr>
		<td align="center" colspan="4"><input type="button" value="지원서 글 수정하기" class="btn">
		<input type="button" value="지원 삭제하기" class="btn"></td>
	</tr>
</table>
</article>
</section>