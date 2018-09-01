<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Scenic" %>
<%@ page import="com.shuangyulin.po.City" %>
<%@ page import="com.shuangyulin.po.ScenicType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的cityObj信息
    List<City> cityList = (List<City>)request.getAttribute("cityList");
    //获取所有的scenicTypeObj信息
    List<ScenicType> scenicTypeList = (List<ScenicType>)request.getAttribute("scenicTypeList");
    Scenic scenic = (Scenic)request.getAttribute("scenic");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改景点信息</TITLE>
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
  		<li class="active">景点信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="scenicEditForm" id="scenicEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="scenic_scenicId_edit" class="col-md-3 text-right">景区id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="scenic_scenicId_edit" name="scenic.scenicId" class="form-control" placeholder="请输入景区id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="scenic_cityObj_cityNo_edit" class="col-md-3 text-right">所在城市:</label>
		  	 <div class="col-md-9">
			    <select id="scenic_cityObj_cityNo_edit" name="scenic.cityObj.cityNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_scenicTypeObj_typeId_edit" class="col-md-3 text-right">景点类型:</label>
		  	 <div class="col-md-9">
			    <select id="scenic_scenicTypeObj_typeId_edit" name="scenic.scenicTypeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_dengji_edit" class="col-md-3 text-right">景点等级:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scenic_dengji_edit" name="scenic.dengji" class="form-control" placeholder="请输入景点等级">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_scenicName_edit" class="col-md-3 text-right">景点名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scenic_scenicName_edit" name="scenic.scenicName" class="form-control" placeholder="请输入景点名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_scenicPhoto_edit" class="col-md-3 text-right">景区图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="scenic_scenicPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="scenic_scenicPhoto" name="scenic.scenicPhoto"/>
			    <input id="scenicPhotoFile" name="scenicPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_scenicDesc_edit" class="col-md-3 text-right">景点介绍:</label>
		  	 <div class="col-md-9">
			    <textarea id="scenic_scenicDesc_edit" name="scenic.scenicDesc" rows="8" class="form-control" placeholder="请输入景点介绍"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_price_edit" class="col-md-3 text-right">门票价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scenic_price_edit" name="scenic.price" class="form-control" placeholder="请输入门票价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_openTime_edit" class="col-md-3 text-right">开放时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scenic_openTime_edit" name="scenic.openTime" class="form-control" placeholder="请输入开放时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_address_edit" class="col-md-3 text-right">景点地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scenic_address_edit" name="scenic.address" class="form-control" placeholder="请输入景点地址">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxScenicModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#scenicEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改景点界面并初始化数据*/
function scenicEdit(scenicId) {
	$.ajax({
		url :  basePath + "Scenic/" + scenicId + "/update",
		type : "get",
		dataType: "json",
		success : function (scenic, response, status) {
			if (scenic) {
				$("#scenic_scenicId_edit").val(scenic.scenicId);
				$.ajax({
					url: basePath + "City/listAll",
					type: "get",
					success: function(citys,response,status) { 
						$("#scenic_cityObj_cityNo_edit").empty();
						var html="";
		        		$(citys).each(function(i,city){
		        			html += "<option value='" + city.cityNo + "'>" + city.cityName + "</option>";
		        		});
		        		$("#scenic_cityObj_cityNo_edit").html(html);
		        		$("#scenic_cityObj_cityNo_edit").val(scenic.cityObjPri);
					}
				});
				$.ajax({
					url: basePath + "ScenicType/listAll",
					type: "get",
					success: function(scenicTypes,response,status) { 
						$("#scenic_scenicTypeObj_typeId_edit").empty();
						var html="";
		        		$(scenicTypes).each(function(i,scenicType){
		        			html += "<option value='" + scenicType.typeId + "'>" + scenicType.typeName + "</option>";
		        		});
		        		$("#scenic_scenicTypeObj_typeId_edit").html(html);
		        		$("#scenic_scenicTypeObj_typeId_edit").val(scenic.scenicTypeObjPri);
					}
				});
				$("#scenic_dengji_edit").val(scenic.dengji);
				$("#scenic_scenicName_edit").val(scenic.scenicName);
				$("#scenic_scenicPhoto").val(scenic.scenicPhoto);
				$("#scenic_scenicPhotoImg").attr("src", basePath +　scenic.scenicPhoto);
				$("#scenic_scenicDesc_edit").val(scenic.scenicDesc);
				$("#scenic_price_edit").val(scenic.price);
				$("#scenic_openTime_edit").val(scenic.openTime);
				$("#scenic_address_edit").val(scenic.address);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交景点信息表单给服务器端修改*/
function ajaxScenicModify() {
	$.ajax({
		url :  basePath + "Scenic/" + $("#scenic_scenicId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#scenicEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#scenicQueryForm").submit();
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
    scenicEdit("<%=request.getParameter("scenicId")%>");
 })
 </script> 
</body>
</html>

