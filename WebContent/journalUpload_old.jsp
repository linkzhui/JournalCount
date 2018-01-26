<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*,db.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Journal Upload</title>
<% 
String user_id = (String) request.getAttribute("userId"); 
String name = "";
int worker_id = 0;
String worker_department="";
out.println("user_id " + user_id);
Connection conn = null;

try {
	// Ensure the driver is imported.
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	try {
		System.out.println("Connecting to \n" + MySQLUtil.URL);
		 conn = DriverManager.getConnection(MySQLUtil.URL);
	} catch (SQLException e) {
		System.out.println("SQLException " + e.getMessage());
		System.out.println("SQLState " + e.getSQLState());
		System.out.println("VendorError " + e.getErrorCode());
	}
	PreparedStatement ps = conn.prepareStatement("select * from users WHERE user_id = ?");
	
	//-----------!!!!!!!!!!!!!
	ps.setString(1, "linkz");
	
	ResultSet rs = ps.executeQuery();
	if (rs.next()) {
		name = rs.getString(3);
		worker_department = rs.getString(5);
		worker_id=rs.getInt(4);
		System.out.println("name: " + name);
		System.out.println("worker_department: " + worker_department);
		System.out.println("worker_id: " + worker_id);
		%>
<script>	

function user_input_verify(){
	var myselect = document.getElementById("select_1");
	var index=myselect.selectedIndex;
	var value = myselect.options[index].value;
	if(value=="Jounral")
	{
		var title = document.getElementById("journal_title").value;
		var notes = document.getElementById("journal_notes").value;
		if(title==""||title.length==0||notes==""||notes.length==0)
		{
			alert("缺少信息,文稿标题必须要填上");
			return false;
		}
		else
		{
			return true;
		}
	}
	else{
		var title = document.getElementById("photograph_title").value;
		var notes = document.getElementById("photograph_notes").value;
		if(title==""||title.length==0||num==""||num.length==0)
		{
			alert("缺少信息,摄影标题和图片数量必须要填上");
			return false;
		}
		else
		{
			return true;
		}
	}
}

function option_select(){
	var myselect = document.getElementById("select_1");
	var index=myselect.selectedIndex;
	if(index==0)
	{
		document.getElementById("journal").style.display="block";
		document.getElementById("photograph").style.display="none";
	}
	else{
		document.getElementById("journal").style.display="none";
		document.getElementById("photograph").style.display="block";
	}
}

</script>
</head>
<body>	
	<h1>投稿</h1>
	<select id="select_1" onchange="option_select()">
		<option value="Jounral">文稿</option>
		<option value="photograph">摄影</option>
	</select>
	<br>
	
	<div id = "journal" style="display:block">
		<form id = "journal_form" method="post" action="/JournalCount/JournalUpload" onsubmit="return user_input_verify(this)">
			稿件标题: <input type="text" name="title" id="journal_title"/> 
			<br /> 
			备注：<input type="text" name="notes" id="journal_notes"/> 
			<br /> 
			<br />
			<input type="hidden" name="user_id" value=<%=user_id%>>
			<input type="hidden" name="input_type" value="journal">
			<input id = "journal_writer_name" type="hidden" name="name" value=<%=name%>>
			<input id = "journal_worker_id" type="hidden" name="worker_id" value=<%=worker_id%>>
			<input id = "journal_worker_department" type="hidden" name="worker_department" value=<%=worker_department%>>
			<input type="submit" value="增加"/>
		</form>
	</div>
	
	<div id = "photograph" style="display:none">
		<form id = "photograph_form" method="post" action="/JournalCount/JournalUpload" onsubmit="return user_input_verify(this)">
			摄影标题: <input type="text" name="title" id="photograph_title"/> 
			<br /> 
			图片数量：<input type="text" name="num" id="photograph_num" onKeyUp="value=value.replace(/[^\d]/g,'')"/> 
			<br /> 
			备注：<input type="text" name="notes" id="notes"/> 
			<br /> 
			<br />
			<input type="hidden" name="user_id" value=<%=user_id%>>
			<input type="hidden" name="input_type" value="photograph">
			<input id = "photograph_writer_name" type="hidden" name="name" value=<%=name%>>
			<input id = "photograph_worker_id" type="hidden" name="worker_id" value=<%=worker_id%>>
			<input id = "photograph_worker_department" type="hidden" name="worker_department" value=<%=worker_department%>>
			<input type="submit" value="增加"/>
		</form>
	</div>
	
		<h2>文稿</h2>

	<%
				ps = conn.prepareStatement("select * from journal WHERE 文章作者 = ?");

				//这里要修改
				ps.setString(1, name);
				rs = ps.executeQuery();
	%>
	<table border="1" width="100%">
		<tr>
			<th>文稿ID</th>
			<th>日期</th>
			<th>稿件标题</th>
			<th>文章作者工号</th>
			<th>文章作者</th>
			<th>作者科室</th>
			<th>稿费</th>
			<th>录用情况</th>
			<th>备注</th>
		</tr>
		<%
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getInt(1)%></td>
			<td><%=rs.getTimestamp(2)%></td>
			<td><%=rs.getString(3)%></td>
			<td><%=rs.getInt(4)%></td>
			<td><%=rs.getString(5)%></td>
			<td><%=rs.getString(6)%></td>
			<td><%=rs.getDouble(7)%></td>
			<td><%=rs.getString(8)%></td>
			<td><%=rs.getString(9)%></td>
		</tr>
		<%
			}
		%>
	</table>
	<br>
	<br>
	<h2>摄影</h2>
	<%
		ps = conn.prepareStatement("select * from photograph WHERE 摄影作者 = ?");
				ps.setString(1, name);
				rs = ps.executeQuery();
	%>
	<table border="1" width="100%">
		<tr>
			<th>摄影稿件ID</th>
			<th>日期</th>
			<th>稿件标题</th>
			<th>图片数量<th>
			<th>摄影作者工号</th>
			<th>摄影作者</th>
			<th>作者科室</th>
			<th>稿费</th>
			<th>录用情况</th>
			<th>备注</th>
		</tr>
		<%
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getInt(1)%></td>
			<td><%=rs.getTimestamp(2)%></td>
			<td><%=rs.getString(3)%></td>
			<td><%=rs.getInt(4)%></td>
			<td><%=rs.getInt(5)%><td>
			<td><%=rs.getString(6)%></td>
			<td><%=rs.getString(7)%></td>
			<td><%=rs.getDouble(8)%></td>
			<td><%=rs.getString(9)%></td>
			<td><%=rs.getString(10)%></td>
		</tr>
		<%
			}
		%>
	</table>

	<%
		}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	%>
	

</body>
</html>