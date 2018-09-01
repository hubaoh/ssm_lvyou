<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.LeaveWord" %>
<%@ page import="com.shuangyulin.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    LeaveWord leaveWord = (LeaveWord)request.getAttribute("leaveWord");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改留言信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">留言信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="leaveWordEditForm" id="leaveWordEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="leaveWord_leaveWordId_edit" class="col-md-3 text-right">留言id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="leaveWord_leaveWordId_edit" name="leaveWord.leaveWordId" class="form-control" placeholder="请输入留言id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="leaveWord_title_edit" class="col-md-3 text-right">标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="leaveWord_title_edit" name="leaveWord.title" class="form-control" placeholder="请输入标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveWord_leaveContent_edit" class="col-md-3 text-right">留言内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="leaveWord_leaveContent_edit" name="leaveWord.leaveContent" rows="8" class="form-control" placeholder="请输入留言内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveWord_addTime_edit" class="col-md-3 text-right">留言时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="leaveWord_addTime_edit" name="leaveWord.addTime" class="form-control" placeholder="请输入留言时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveWord_userObj_user_name_edit" class="col-md-3 text-right">留言人:</label>
		  	 <div class="col-md-9">
			    <select id="leaveWord_userObj_user_name_edit" name="leaveWord.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveWord_replyContent_edit" class="col-md-3 text-right">回复内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="leaveWord_replyContent_edit" name="leaveWord.replyContent" rows="8" class="form-control" placeholder="请输入回复内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveWord_replyTime_edit" class="col-md-3 text-right">回复时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="leaveWord_replyTime_edit" name="leaveWord.replyTime" class="form-control" placeholder="请输入回复时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxLeaveWordModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#leaveWordEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改留言界面并初始化数据*/
function leaveWordEdit(leaveWordId) {
	$.ajax({
		url :  basePath + "LeaveWord/" + leaveWordId + "/update",
		type : "get",
		dataType: "json",
		success : function (leaveWord, response, status) {
			if (leaveWord) {
				$("#leaveWord_leaveWordId_edit").val(leaveWord.leaveWordId);
				$("#leaveWord_title_edit").val(leaveWord.title);
				$("#leaveWord_leaveContent_edit").val(leaveWord.leaveContent);
				$("#leaveWord_addTime_edit").val(leaveWord.addTime);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#leaveWord_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#leaveWord_userObj_user_name_edit").html(html);
		        		$("#leaveWord_userObj_user_name_edit").val(leaveWord.userObjPri);
					}
				});
				$("#leaveWord_replyContent_edit").val(leaveWord.replyContent);
				$("#leaveWord_replyTime_edit").val(leaveWord.replyTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交留言信息表单给服务器端修改*/
function ajaxLeaveWordModify() {
	$.ajax({
		url :  basePath + "LeaveWord/" + $("#leaveWord_leaveWordId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#leaveWordEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#leaveWordQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    leaveWordEdit("<%=request.getParameter("leaveWordId")%>");
 })
 </script> 
</body>
</html>

