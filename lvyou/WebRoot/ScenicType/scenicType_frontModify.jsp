<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.ScenicType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    ScenicType scenicType = (ScenicType)request.getAttribute("scenicType");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改景点分类信息</TITLE>
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
  		<li class="active">景点分类信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="scenicTypeEditForm" id="scenicTypeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="scenicType_typeId_edit" class="col-md-3 text-right">类型id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="scenicType_typeId_edit" name="scenicType.typeId" class="form-control" placeholder="请输入类型id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="scenicType_typeName_edit" class="col-md-3 text-right">类别名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scenicType_typeName_edit" name="scenicType.typeName" class="form-control" placeholder="请输入类别名称">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxScenicTypeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#scenicTypeEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改景点分类界面并初始化数据*/
function scenicTypeEdit(typeId) {
	$.ajax({
		url :  basePath + "ScenicType/" + typeId + "/update",
		type : "get",
		dataType: "json",
		success : function (scenicType, response, status) {
			if (scenicType) {
				$("#scenicType_typeId_edit").val(scenicType.typeId);
				$("#scenicType_typeName_edit").val(scenicType.typeName);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交景点分类信息表单给服务器端修改*/
function ajaxScenicTypeModify() {
	$.ajax({
		url :  basePath + "ScenicType/" + $("#scenicType_typeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#scenicTypeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "ScenicType/frontlist";
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
    scenicTypeEdit("<%=request.getParameter("typeId")%>");
 })
 </script> 
</body>
</html>

