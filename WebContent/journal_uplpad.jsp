<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; IE=8; charset=UTF-8">
<title>稿件投稿</title>
</head>
<script>
function user_input_verify(){
	var title = document.getElementById("title").value;
	var date = document.getElementById("date").value;
	if(title==""||title.length==0||date==""||date.length==0)
	{
		alert("稿件标题和投稿日期必须填写");
		return false;
	}
	else{
		return true;
	}
}
</script>
<body>
<% 
	String alert = (String)request.getAttribute("alert");
	if(alert!=null)
	{
		if(alert.equals("yes"))
		{
			%>
			<script>alert("提交失败")</script>
			<%
		}
		else{
			%>
			<script>alert("提交成功")</script>
			<%
		}
	}
%>
<div>
<h1>稿件投稿</h1>
<form id = "journal_form" method="post" action="/JournalCount/JournalUpload" onsubmit="return user_input_verify(this)">
			<label>稿件标题: <input type="text" name="title" id = "title"/> </label>
			<br />
			<label>投稿日期: <input type="date" name="date" id = "date"/></label> 
			<br />
			<label>图片数量: <input type="text" name="photo_num"/ onKeyUp="value=value.replace(/[^\d]/g,'')"></label> 
			<br />
			<label>文章作者工号: <input type="text" name="journal_id" onKeyUp="value=value.replace(/[^\d]/g,'')"/></label> 
			<br />
			<label>文章作者名字: <input type="text" name="journal_name"/></label> 
			<br />
			<label>文章作者科室: <input type="text" name="journal_department"/></label> 
			<br />
			<label>摄影作者工号: <input type="text" name="photograph_id" onKeyUp="value=value.replace(/[^\d]/g,'')"/></label> 
			<br />
			<label>摄影作者名字: <input type="text" name="photograph_name"/></label> 
			<br />
			<label>摄影作者科室: <input type="text" name="photograph_department"/></label> 
			<br />
			<label>备注：<input type="text" name="notes"/> </label>
			<br /> 
			<br />
			<input type="submit" value="增加"/>
</form>
</div>
</body>
</html>