<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
function rcClick(){
	var result = confirm('모집을 종료하시겠습니까?');
    if(result==true){
    	document.all.rc.style.background="red";
    	document.all.rc.value="모집 종료";
    	document.all.rc.disabled="true";
    	}
}
</script>
<style>
table{
	border: gray 1px solid;
	padding: 10px;
	width:800px;
}
.pfimg{
	width:50px;
	height:50px;
	padding:2px;
}
.t1{
	width: 80px;
	height: 50px;
	font-size: 22px;
	font-weight: bold;
}
.t2{
	width: 110px;
	height:50px;
	color: gray;
	font-weight: bold;
}
.t3{
	color: darkgray;
	font-weight: bold;
}
.t5{
	border-top: gray 1px dotted;
	border-bottom: gray 1px dotted;
}
.btn{
	width:100px;
	height:40px;
	background: lightgray;
	font-size:15px;
	font-weight: bold;
}
</style>
<table>
<tr>
	<td align="right" colspan="10"><input type="button" value="모집중" id="rc" onclick="rcClick();"
	style="width:100px;height:40px;background: green;font-size:15px;color:white;"></td>
</tr>
<tr>
	<td class="pfimg" rowspan="2"><img src="/sp/img/profile.jpg" class="pfimg"></td>
	<td style="font-size:20px;font-weight:bold;"colspan="9">공모전명</td>
</tr>
<tr>
	<td colspan="9">모임명 | 모임 주최자</td>
</tr>
<tr>
	<td rowspan="9"></td><td  class="t3"  colspan="9">현재 인원</td>
</tr>
<tr>
	<td class="pfimg"><img src="/sp/img/profile.jpg" class="pfimg"></td>
	<td class="t1">작성자</td>
	<td class="t2">안드로이드</td>
	<td class="pfimg"><img src="/sp/img/profile.jpg" class="pfimg"></td>
	<td class="t2">편집디자인</td>
	<td>1명</td>
	<td class="pfimg"><img src="/sp/img/profile.jpg" class="pfimg"></td>
	<td class="t2">IOS</td>
	<td>1명</td>
</tr>
<tr>
	<td class="t3" colspan="9">이 모임에 지원중인 사람</td>
</tr>
<tr>
	<td class="pfimg"><img src="/sp/img/profile.jpg" class="pfimg"></td>
	<td class="t1">김영희
	<td class="t2">IOS<br>서버</td>
	<td align="center" colspan="4"><a>지원글 상세보기</a></td>
	<td align="right" colspan="2">
		<a style="color:green;font-weight: bold;">승인</a>
		<a style="color:red;font-weight: bold;">삭제</a>
	</td>
</tr>
<tr>
	<td class="pfimg"><img src="/sp/img/profile.jpg" class="pfimg"></td>
	<td class="t1">김영희
	<td class="t2">IOS<br>서버</td>
	<td align="center" colspan="4"><a>지원글 상세보기</a></td>
	<td align="right" colspan="2">
		<a style="color:green;font-weight: bold;">승인</a>
		<a style="color:red;font-weight: bold;">삭제</a>
	</td>
</tr>
<tr>
	<td align="right" colspan="9">
	<input type="button" value="수정하기" class="btn">
	<input type="button" value="삭제하기" class="btn">
	</td>
</tr>
</table>