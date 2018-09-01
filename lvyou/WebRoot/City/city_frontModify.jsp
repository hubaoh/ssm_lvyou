<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.City" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    City city = (City)request.getAttribute("city");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改城市信息</TITLE>
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
  		<li class="active">城市信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="cityEditForm" id="cityEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="city_cityNo_edit" class="col-md-3 text-right">城市代码:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="city_cityNo_edit" name="city.cityNo" class="form-control" placeholder="请输入城市代码" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="city_cityName_edit" class="col-md-3 text-right">城市名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="city_cityName_edit" name="city.cityName" class="form-control" placeholder="请输入城市名称">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxCityModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#cityEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改城市界面并初始化数据*/
function cityEdit(cityNo) {
	$.ajax({
		url :  basePath + "City/" + cityNo + "/update",
		type : "get",
		dataType: "json",
		success : function (city, response, status) {
			if (city) {
				$("#city_cityNo_edit").val(city.cityNo);
				$("#city_cityName_edit").val(city.cityName);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交城市信息表单给服务器端修改*/
function ajaxCityModify() {
	$.ajax({
		url :  basePath + "City/" + $("#city_cityNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#cityEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "City/frontlist";
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
    cityEdit("<%=request.getParameter("cityNo")%>");
 })
 </script> 
</body>
</html>

