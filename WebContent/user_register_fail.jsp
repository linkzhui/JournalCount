<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function alert_message(){
	alert("该用户名已经被注册");
}
function user_input_verify(){
	var user = document.getElementById("user").value;  
	var password =  document.getElementById("password").value;  
	var name = document.getElementById("name").value;
	var work_id = document.getElementById("work_id").value;
	var email = document.getElementById("email").value;
	if(user==""||user.length==0||password==""||password.length==0||name==""||name.length==0||work_id==""||work_id.length==0||email==""||email.length==0)
	{
		alert("缺少信息");
		return false;
	}
	else
	{
		return true;
	}
}
</script>
</head>
<body onload="alert_message()">
<form method="post" action="/JournalCount/UserRegisterAction" onsubmit="return user_input_verify(this)">
用户名: <input type="text" name="user" id="user">
<br />
密码：<input type="password" name="password" id="password">
<br />
姓名：<input type="text" name="name" id="name">
<br />
邮箱：<input type="text" name="email" id="email">
<br />
工号：<input type="text" name="work_id" id="work_id">
<br /><br />
<input type="submit" value="注册" />
</form>
</body>
</html>