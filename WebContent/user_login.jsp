<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户登入</title>
<script>
function login(){
	if(document.getElementById("user").value=='' && document.getElementById("password").value=='')
	{
		alert("缺少用户名或者密码");
		return false;
	}
	else{
		return true;
	}
}
</script>
</head>
<body>

<form method="get" action="/JournalCount/UserLoginAction" onsubmit="return login(this)">
用户名: <input type="text" name="user" id="user">
<br />
密码：<input type="password" name="password" id="password">
<br /><br />
<input type="submit" value="登入" />
<input type ="button" value="注册" onclick="window.location.href='user_register.jsp'">
</form>


<br />
<p id = "test"></p>
</body>
</html>