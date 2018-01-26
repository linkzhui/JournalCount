<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*,db.*,model.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; IE=8; charset=UTF-8">
<title>admin page</title>
<%
	String sql = (String) request.getAttribute("sql");
%>
</head>
<script  src="jquery-3.2.1.js"></script>
<script type="text/javascript">
function Set() {
    this.elements = new Array();
    //获取Set元素个数
    this.size = function() {
        return this.elements.length;
    }

    //判断Set是否为空
    this.isEmpty = function() {
        return (this.elements.length < 1);
    }

    //清除Set
    this.clear = function() {
        this.elements = new Array();
    }
    //增加一个元素，不重复
    this.add = function(value) {
        //alert(this.containsKey(_key));
        if(this.containsValue(value)){
            this.remove(value);
        }
        this.elements.push(value);
    }
    //移除一个值
    this.remove = function(value) {
        var bln = false;
        try {

            for (i = 0; i < this.elements.length; i++) {

                if (this.elements[i] == value) {

                    this.elements.splice(i, 1);

                    return true;
                }
            }
        } catch (e) {
            bln = false;
        }
        return bln;
    }

    //移除一个值,索引
    this.kill=function (index){
        this.remove(this.get(index));
    }

    //得到一个值,索引
    this.get = function(_index) {
        if (_index < 0 || _index >= this.elements.length) {
            return null;
        }
        return this.elements[_index];
    }

    //查看是否包含一个值
    this.containsValue = function(value) {
        var bln = false;
        try {
            for (i = 0; i < this.elements.length; i++) {
                if (this.elements[i] == value) {
                    bln = true;
                }
            }
        } catch (e) {
            bln = false;
        }
        return bln;
    }
}
	
	var select_set = new Set();
	function checkboxOnclick(checkbox){
		if(checkbox.checked)
		{
			select_set.add(checkbox.id);
		}
		else{
			select_set.remove(checkbox.id);
		}
	};
	
	/* function modify_db(button){

		if(button.id=="delete")
		{
			  alert("click");
			  var form1 = document.createElement("form"); 
			  form1.id = "form1"; 
			  form1.name = "form1"; 
			  // 添加到 body 中 
			  document.body.appendChild(form1); 	  
			  var jsonData = JSON.stringify(select_set);
			  var input = document.createElement("input"); 
			  // 设置相应参数
			  input.type = "text"; 
			  input.name = "data"; 
		      input.value = select_set; 
			  form1.appendChild(input); 
			  form1.contentType = "application/x-www-form-urlencoded";
			  // form 的提交方式 
			  form1.method = "POST"; 
			  // form 提交路径 
			  form1.action = "/JournalCount/AdminPageDBUpdate"; 
			  // 对该 form 执行提交 
			  form1.submit(); 
			  // 删除该 form 
			  document.body.removeChild(form1);
		}
		else{
			//update the database
			
			//INSERT INTO `稿件统计` (`序号`, `修改日期`, `日期`, `稿件标题`, `图片数量`, `文章作者工号`, `文章作者`, `文章作者科室`, `摄影作者工号`, `摄影作者`, `摄影作者科室`, `稿费`, `录用情况`, `备注`, `录用级别`, `媒体名称`, `网址`, `积分`) VALUES (NULL, CURRENT_TIMESTAMP, '2018-01-19', 'Friday', '3', '1244', '12314', 'IT', '1245', 'IT', 'IT', '0', 'No', NULL, NULL, NULL, NULL, NULL);
			
		}
	} */
	
	var pass_data = [];
	$(document).ready(function(){
	    $("#delete").click(function(){
	    	pass_data = [];
	    	for(var i = 0;i<select_set.size();i++)
	    		{
	    			pass_data.push(select_set.get(i));
	    		}
	    /* 	alert("click delete"); */
	    	$.ajax({
	    	    url: "/JournalCount/AdminPageDBUpdate",
	    	    type: "GET",
	    	    data: {
	    	        "list": pass_data,
	    	        "option": "delete",
	    	    },
	    	    success: function(data,status) {
	    	    	window.location.reload();
	    	    }
	    	});
	    });
	    $("#modify").click(function(){
	    	var update_data="";
	    	var j = 0;
	    	for(j = 0;j<record_set.size();j++)
	    	{
	    		
	    		//修改这里
	    		var id = record_set.get(j);
	    		var sql = "UPDATE `稿件统计` SET `日期` = '" +document.getElementById('date_'+id).innerHTML
	    		+
	    		"', `稿件标题` = '"+document.getElementById('title_'+id).innerHTML+
	    		"', `图片数量` = '"+document.getElementById('photo_num_'+id).innerHTML +
	    		"', `文章作者工号` = '"+document.getElementById("journal_id_"+id).innerHTML+
	    		"', `文章作者` = '"+document.getElementById("journal_name_"+id).innerHTML+
	    		"', `文章作者科室` = '"+document.getElementById("journal_department_"+id).innerHTML+
	    		"', `摄影作者工号` = '"+document.getElementById("photograph_id_"+id).innerHTML+
	    		"', `摄影作者` = '"+document.getElementById("photograph_name_"+id).innerHTML+
	    		"', `摄影作者科室` = '"+document.getElementById("photograph_department_"+id).innerHTML+
	    		"', `稿费` = '"+document.getElementById("payment_"+id).innerHTML;
	    		
	    		var id = record_set.get(j);
	    		var accept_status = document.getElementById("accept_status_"+id);
	    		var accept_status_val = "";
	    		var accept_status_index=accept_status.selectedIndex;
	    		if(accept_status_index==0)
	    		{
	    			accept_status_val = "No";
	    		}
	    		else{
	    			accept_status_val = "Yes";
	    		}
	    		
	    		sql+="', `录用情况` = '"+accept_status_val;
	    		
	    		var accept_level = document.getElementById("accept_level_"+id);
	    		var prefix = "";
	    		var accept_level_val = "";
	    		
	    		if (null !== accept_level && typeof(accept_level) != "undefined") {
	    		     for(var z=0;z<accept_level.options.length;z++) {  
	    		         if(accept_level.options[z].selected) {
	    		        	 accept_level_val+=prefix+accept_level.options[z].value;
	    		        	 prefix=",";
	    		         }  
	    		     }
	    		     if(accept_level_val!=="")
	    		    {
	    		    	 sql+="', `录用级别` = '"+accept_level_val;
	    		   	}
	    		     
	    		}
	    		
	    	
	    		var media = document.getElementById("media_"+id);
	    		prefix = "";
	    		var media_val = "";	    		
	    		
	    		if (null !== media && typeof(media) != "undefined") {
	    		     for(var x=0;x<media.options.length;x++) {  
	    		         if(media.options[x].selected) {
	    		        	 media_val+=prefix+media.options[x].value;
	    		        	 prefix=",";
	    		         }  
	    		     }
	    		     if(media_val!=="")
	    		    {
	    		    	 sql+="', `媒体名称` = '"+media_val;
	    		   	}
	    		     
	    		}
	    	
	    		var score = document.getElementById("score_"+id);
	    		prefix = "";
	    		var score_val = "";	    		
	    		
	    		if (null !== score && typeof(score) != "undefined") {
	    		     for(var x=0;x<score.options.length;x++) {  
	    		         if(score.options[x].selected) {
	    		        	 score_val+=prefix+score.options[x].value;
	    		        	 prefix=",";
	    		         }  
	    		     }
	    		     if(score_val!=="")
	    		    {
	    		    	 sql+="', `积分` = '"+score_val;
	    		   	}
	    		     
	    		}
	    		
	    		sql+="', `网址` = '"+document.getElementById("web_"+id).innerHTML+
	    		"' "+ " WHERE `稿件统计`.`序号` = "+id;
	    		$.ajax({
		    	    url: "/JournalCount/AdminPageDBUpdate",
		    	    type: "GET",
		    	    data: {
		    	        "sql": sql,
		    	        "option": "modify",
		    	    },
		    	    success: function(data,status) {
		    	        if(status==="success")
		    	        {
		    	        	window.location.reload();
		    	        }
		    	    }
		    	}); 
	    	}
	    });
	});
	
	var record_set = new Set();
	function record_change(data){
		record_set.add(data.id);
	}

	function score_change(score){
		//score_
		var id = score.id.slice(6);
		var myselect = document.getElementById(score.id);
		var index=myselect.selectedIndex;
		var result;
		if(index<=2)
		{
			result = index*2*20
		}
		else{
			var result = (index+1)*2*20
		}
		
		document.getElementById("payment_"+id).innerHTML=result;
	}
	
	/* function verify_media(media){
		//media_
		var id = media.id.slice(6);
		var accept_select = document.getElementById("accept_level_"+id);
		var index = accept_select.selectedIndex;
	} */
	
	function update_title(title)
	{
		alert(title.innerHTML);
	}

</script>
<body>
	<h1>搜索</h1>
	<br>
	<p>如果选项为空，便可以显示所有稿件信息</p>
	<br>
	<form action="/JournalCount/AdminPageAction" id="form">
		<select name="search_option">
			<option value="precission">精准搜索</option>
			<option value="fuzzy">模糊搜索</option>
		</select> <br> <label>稿件名称：<input type="text" name="title"></label>
		<br> <label>稿件日期：<input type="date" name="date"></label>
		<br> <label>最后修改日期：<input type="date" name="update_date"></label>
		<br> <label>图片数量: <input type="text" name="photo_num" onKeyUp="value=value.replace(/[^\d]/g,'')"/></label>
		<br /> <label>文章作者工号: <input type="text" name="journal_id" onKeyUp="value=value.replace(/[^\d]/g,'')"/></label>
		<br /> <label>文章作者名字: <input type="text" name="journal_name" /></label>
		<br /> <label>文章作者科室: <input type="text"
			name="journal_department" /></label> <br /> <label>摄影作者工号: <input
			type="text" name="photograph_id" /></label> <br /> <label>摄影作者名字: <input
			type="text" name="photograph_name" /></label> <br /> <label>摄影作者科室:
			<input type="text" name="photograph_department" />
		</label> <br /> <br> <input type="submit" value="搜索" style="width:100px; height:50px;">
	</form>
	<%
		List<JournalData> data = (List<JournalData>) request.getAttribute("list_data");
		if (data != null) {
			Iterator<JournalData> iter = data.iterator();
			int num = 0;
	%>

			<br>
			<%-- <form id="modify_form" method = "post" action = "/JournalCount/AdminPageDBUpdate" onsubmit = "modify_db(this)">
				<input type = "hidden" name = "sql" value=<%=sql%>>
				<input type = "submit" value = "删除">
				<input type = "submit" value = "修改">
			</form> --%>
			
	<div id="search_result">
		<h2 align="center">搜索结果</h2>
		
		<br>
		<label>1. 勾选后删除，如果要修改的话可以直接修改，然后再点击最下面的修改按钮，完成更新</label>
		<br>
		<label>2. 录用级别和媒体名称可多选</label>
		<br>
		<p>对于 windows：按住 Ctrl 按钮来选择多个选项，对于 Mac：按住 command 按钮来选择多个选项</p>
			<br />
			<button id = "delete" value = "删除" style="width:100px; height:20px">删除</button>
			<br />
		<button id = "modify" value = "修改" style="width:100px; height:20px">修改</button>
		<br />
		<table border="1" width="100%">
			<tr>
				<th></th>
				<th>序号</th>
				<th>修改日期</th>
				<th>稿件日期</th>
				<th>稿件标题</th>
				<th>图片数量</th>
				<th>文章作者工号</th>
				<th>文章作者名字</th>
				<th>文章作者科室</th>
				<th>摄影作者工号</th>
				<th>摄影作者名字</th>
				<th>摄影作者科室</th>
				<th>积分</th>
				<th>稿费(元)</th>
				<th>录用情况</th>
				<th>备注</th>
				<th>录用级别（可多选）</th>
				<th>媒体名称（可多选）</th>
				<th>网址</th>
				
			</tr>
			<%
				while (iter.hasNext()) {
						JournalData temp_date = iter.next();
						String check_box_id = ""+temp_date.getId();
			%>
			<tr id=<%=temp_date.getId()%> onclick="record_change(this)">
				<td><input id=<%=check_box_id%>
					type="checkbox" onblur="checkboxOnclick(this)"></td>
				<td><%=temp_date.getId()%></td>
				<td><%=temp_date.getUpdate_date()%></td>
				<td id=<%="date_"+ temp_date.getId()%> contenteditable='true'><%=temp_date.getDate()%></td>
				<td id=<%="title_"+ temp_date.getId()%> contenteditable='true'><%=temp_date.getTitle()%></td>
				<td id=<%="photo_num_"+ temp_date.getId()%> contenteditable='true' onKeyUp="value=value.replace(/[^\d]/g,'')" <%=temp_date.getPhoto_num()%>)"><%=temp_date.getPhoto_num()%></td>
				<td id=<%="journal_id_"+ temp_date.getId()%> contenteditable='true' onKeyUp="value=value.replace(/[^\d]/g,'')" <%=temp_date.getJournal_id()%>)"><%=temp_date.getJournal_id()%></td>
				<td id=<%="journal_name_"+ temp_date.getId()%> contenteditable='true'><%=temp_date.getJournal_name()%></td>
				<td id=<%="journal_department_"+ temp_date.getId()%> contenteditable='true'><%=temp_date.getJournal_department()%></td>
				<td id=<%="photograph_id_"+ temp_date.getId()%> contenteditable='true' onKeyUp="value=value.replace(/[^\d]/g,'')" <%=temp_date.getPhorograph_id()%>)"><%=temp_date.getPhorograph_id()%></td>
				<td id=<%="photograph_name_"+ temp_date.getId()%> contenteditable='true'><%=temp_date.getPhorograph_name()%></td>
				<td id=<%="photograph_department_"+ temp_date.getId()%> contenteditable='true'><%=temp_date.getPhorograph_department()%></td>
				<td><select id=<%="score_"+ temp_date.getId()%> onchange="score_change(this)">
						<option value="0" <%if (temp_date.getScore()==null||temp_date.getScore().equals("0")) {%>
							selected="selected" <%}%>>0分</option>
						<option value="2" <%if (temp_date.getScore()!=null&&temp_date.getScore().equals("2")) {%>
							selected="selected" <%}%>>2分</option>
						<option value="4" <%if (temp_date.getScore()!=null&&temp_date.getScore().equals("4")) {%>
							selected="selected" <%}%>>4分</option>
						<option value="8" <%if (temp_date.getScore()!=null&&temp_date.getScore().equals("8")) {%>
							selected="selected" <%}%>>8分</option>
						<option value="10" <%if (temp_date.getScore()!=null&&temp_date.getScore().equals("10")) {%>
							selected="selected" <%}%>>10分</option>
				</select></td>
				<td id=<%="payment_"+ temp_date.getId()%>><%=temp_date.getPayment() %></td>
				<td><select id = <%="accept_status_"+ temp_date.getId()%>>
						<option value="accept_no"
							<%if (temp_date.getAccept_status().equals("No")) {%>
							selected="selected" <%}%>>No</option>
						<option value="accept_yes"
							<%if (temp_date.getAccept_status().equals("Yes")) {%>
							selected="selected" <%}%>>Yes</option>
				</select>
			    </td>
				<td contenteditable='true' id=<%="note_"+ temp_date.getId()%>><%=temp_date.getNote()%></td>
				<td>
				<%-- <form action="">
				<label><input name="Accept_level" type="checkbox" value="" <%if (temp_date.getAccept_level().indexOf("瑞安市级")!=-1) {%>
							checked="checked" <%}%>>/>瑞安市级 </label>
				<label><input name="Accept_level" type="checkbox" value="" <%if (temp_date.getAccept_level().indexOf("温州市级及以上")!=-1) {%>
							checked="checked" <%}%>>/>温州市级及以上</label>
				<label><input name="Accept_level" type="checkbox" value="" <%if (temp_date.getAccept_level().indexOf("省级及以上")!=-1) {%>
							checked="checked" <%}%>>/>省级及以上</label>
				<label><input name="Accept_level" type="checkbox" value="" <%if (temp_date.getAccept_level().indexOf("国家级")!=-1) {%>
							checked="checked" <%}%>>/>国家级</label>
				</form> --%>
				<%
					String accept_level = "accept_level_"+temp_date.getId();
					String media = "media_"+temp_date.getId();
				%>
				<select name= “accept_level” id=<%=accept_level%> multiple=”multiple”>
       				<option value="瑞安市级" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("瑞安市级")!=-1) {%>
							selected="selected" <%}%>>瑞安市级</option>
       				<option value="温州市级及以上" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("温州市级及以上")!=-1) {%>
							selected="selected" <%}%>>温州市级及以上</option>
       				<option value="省级及以上" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("省级及以上")!=-1) {%>
							selected="selected" <%}%>>省级及以上</option>
       				<option value="国家级" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("国家级")!=-1) {%>
							selected="selected" <%}%>>国家级</option>
				</select>
				<%-- <%=temp_date.getAccept_level()%> --%>
				</td>
				<td>
				<select name= “media” id=<%=media%>  multiple=”multiple”>
				
					<option background-color: #EEEEEE;" disabled="disabled" label = "瑞安市级"></option>
       				<option id=<%=media+"_1"%> value="瑞安市卫计局（网站）" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("瑞安市卫计局（网站）")!=-1) {%>
							selected="selected" <%}%>>瑞安市卫计局（网站）</option>
       				<option id=<%=media+"_2"%> value="瑞安市卫计局（微信）" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("瑞安市卫计局（微信）")!=-1) {%>
							selected="selected" <%}%>>瑞安市卫计局（微信）</option>
       				<option id=<%=media+"_3"%> value= "瑞安日报（报纸）" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("瑞安日报（报纸）")!=-1) {%>
							selected="selected" <%}%>>瑞安日报（报纸）</option>
       				<option id=<%=media+"_4"%> value = "瑞安日报（微信）" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("瑞安日报（微信）")!=-1) {%>
							selected="selected" <%}%>>瑞安日报（微信）</option>
					<option id=<%=media+"_5"%> value = "瑞安无线" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("瑞安无线")!=-1) {%>
							selected="selected" <%}%>>瑞安无线</option>
							
					<option background-color: #EEEEEE;" disabled="disabled" label = "温州市级及以上"></option>
					<option id=<%=media+"_6"%> value = "温州妇幼保健所（网站）" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("温州妇幼保健所（网站）")!=-1) {%>
							selected="selected" <%}%>>温州妇幼保健所（网站）</option>
					<option id=<%=media+"_7"%> value = "温州妇幼保健所（微信）" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("温州妇幼保健所（微信）")!=-1) {%>
							selected="selected" <%}%>>温州妇幼保健所（微信）</option>
					<option id=<%=media+"_8"%> value = "温州市卫计委（网站）" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("温州市卫计委（网站）")!=-1) {%>
							selected="selected" <%}%>>温州市卫计委（网站）</option>
					<option id=<%=media+"_9"%> value = "温州市卫计委（微信）" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("温州市卫计委（微信）")!=-1) {%>
							selected="selected" <%}%>>温州市卫计委（微信）</option>
					<option id=<%=media+"_10"%> value = "温州日报" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("温州日报")!=-1) {%>
							selected="selected" <%}%>>温州日报</option>
					<option id=<%=media+"_11"%> value = "温州晚报" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("温州晚报")!=-1) {%>
							selected="selected" <%}%>>温州晚报</option>
						
					<option background-color: #EEEEEE;" disabled="disabled" label = "省级及以上"></option>	
					<option id=<%=media+"_12"%> value = "省卫计委（网站）" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("省卫计委（网站）")!=-1) {%>
							selected="selected" <%}%>>省卫计委（网站）</option>
					<option id=<%=media+"_13"%> value = "浙江日报" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("浙江日报")!=-1) {%>
							selected="selected" <%}%>>浙江日报</option>
					<option id=<%=media+"_14"%> value = "浙江人民广播电台" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("浙江人民广播电台")!=-1) {%>
							selected="selected" <%}%>>浙江人民广播电台</option>
					<option id=<%=media+"_15"%> value = "浙江电视台" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("浙江电视台")!=-1) {%>
							selected="selected" <%}%>>浙江电视台</option>
					<option id=<%=media+"_16"%> value = "浙江在线" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("浙江在线")!=-1) {%>
							selected="selected" <%}%>>浙江在线</option>
					<option id=<%=media+"_17"%> value = "健康浙江杂志与微信" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("健康浙江杂志与微信")!=-1) {%>
							selected="selected" <%}%>>健康浙江杂志与微信</option>
					<option id=<%=media+"_18"%> value = "钱江晚报" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("钱江晚报")!=-1) {%>
							selected="selected" <%}%>>钱江晚报</option>
					<option id=<%=media+"_19"%> value = "今日早报" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("今日早报")!=-1) {%>
							selected="selected" <%}%>>今日早报</option>
					<option id=<%=media+"_20"%> value = "青年时报" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("青年时报")!=-1) {%>
							selected="selected" <%}%>>青年时报</option>
					
					<option background-color: #EEEEEE;" disabled="disabled" label = "国家级"></option>	
					<option id=<%=media+"_21"%> value = "新华每日电讯" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("新华每日电讯")!=-1) {%>
							selected="selected" <%}%>>新华每日电讯</option>
					<option id=<%=media+"_22"%> value = "求是" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("求是")!=-1) {%>
							selected="selected" <%}%>>求是</option>
					<option id=<%=media+"_23"%> value = "人民日报" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("人民日报")!=-1) {%>
							selected="selected" <%}%>>人民日报</option>
					<option id=<%=media+"_24"%> value = "光明日报" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("光明日报")!=-1) {%>
							selected="selected" <%}%>>光明日报</option>
					<option id=<%=media+"_25"%> value = "中央电视台" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("中央电视台")!=-1) {%>
							selected="selected" <%}%>>中央电视台</option>
					<option id=<%=media+"_26"%> value = "人民网" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("人民网")!=-1) {%>
							selected="selected" <%}%>>人民网</option>
					<option id=<%=media+"_27"%> value = "新华网" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("新华网")!=-1) {%>
							selected="selected" <%}%>>新华网</option>
					<option id=<%=media+"_28"%> value = "中央人民广播电台" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("中央人民广播电台")!=-1) {%>
							selected="selected" <%}%>>中央人民广播电台</option>
					<option id=<%=media+"_29"%> value = "健康报"<%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("健康报")!=-1) {%>
							selected="selected" <%}%>>健康报</option>
					<option id=<%=media+"_30"%> value = "中国人口报" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("中国人口报")!=-1) {%>
							selected="selected" <%}%>>中国人口报</option>
					<option id=<%=media+"_31"%> value = "中国中医药报" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("中国中医药报")!=-1) {%>
							selected="selected" <%}%>>中国中医药报</option>
					<option id=<%=media+"_32"%> value = "人口和计划生育杂志" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("人口和计划生育杂志")!=-1) {%>
							selected="selected" <%}%>>人口和计划生育杂志</option>
					<option id=<%=media+"_33"%> value = "中国卫生杂志" <%if (temp_date.getAccept_level()!=null&&temp_date.getAccept_level().indexOf("中国卫生杂志")!=-1) {%>
							selected="selected" <%}%>>中国卫生杂志</option>
				</select>
				</td>
				<td id=<%="web_"+ temp_date.getId()%> contenteditable='true'><%=temp_date.getWeb()%></td></tr>
				<%
				}
			%>
		</table>
		
	</div>
	<%
		}
	%>
</body>
</html>