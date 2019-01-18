<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.removeAttribute("smname");
session.removeAttribute("sidEmail");
response.sendRedirect("/sp");
%>