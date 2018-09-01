<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.City" %>
<%@ page import="com.shuangyulin.po.ScenicType" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>景点添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Scenic/frontlist">景点管理</a></li>
  			<li class="active">添加景点</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="scenicAddForm" id="scenicAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="scenic_cityObj_cityNo" class="col-md-2 text-right">所在城市:</label>
				  	 <div class="col-md-8">
					    <select id="scenic_cityObj_cityNo" name="scenic.cityObj.cityNo" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="scenic_scenicTypeObj_typeId" class="col-md-2 text-right">景点类型:</label>
				  	 <div class="col-md-8">
					    <select id="scenic_scenicTypeObj_typeId" name="scenic.scenicTypeObj.typeId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="scenic_dengji" class="col-md-2 text-right">景点等级:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="scenic_dengji" name="scenic.dengji" class="form-control" placeholder="请输入景点等级">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="scenic_scenicName" class="col-md-2 text-right">景点名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="scenic_scenicName" name="scenic.scenicName" class="form-control" placeholder="请输入景点名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="scenic_scenicPhoto" class="col-md-2 text-right">景区图片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="scenic_scenicPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="scenic_scenicPhoto" name="scenic.scenicPhoto"/>
					    <input id="scenicPhotoFile" name="scenicPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="scenic_scenicDesc" class="col-md-2 text-right">景点介绍:</label>
				  	 <div class="col-md-8">
					    <textarea id="scenic_scenicDesc" name="scenic.scenicDesc" rows="8" class="form-control" placeholder="请输入景点介绍"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="scenic_price" class="col-md-2 text-right">门票价格:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="scenic_price" name="scenic.price" class="form-control" placeholder="请输入门票价格">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="scenic_openTime" class="col-md-2 text-right">开放时间:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="scenic_openTime" name="scenic.openTime" class="form-control" placeholder="请输入开放时间">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="scenic_address" class="col-md-2 text-right">景点地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="scenic_address" name="scenic.address" class="form-control" placeholder="请输入景点地址">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxScenicAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#scenicAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加景点信息
	function ajaxScenicAdd() { 
		//提交之前先验证表单
		$("#scenicAddForm").data('bootstrapValidator').validate();
		if(!$("#scenicAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Scenic/add",
			dataType : "json" , 
			data: new FormData($("#scenicAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#scenicAddForm").find("input").val("");
					$("#scenicAddForm").find("textarea").val("");
				} else {
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
	//验证景点添加表单字段
	$('#scenicAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"scenic.dengji": {
				validators: {
					notEmpty: {
						message: "景点等级不能为空",
					}
				}
			},
			"scenic.scenicName": {
				validators: {
					notEmpty: {
						message: "景点名称不能为空",
					}
				}
			},
			"scenic.scenicDesc": {
				validators: {
					notEmpty: {
						message: "景点介绍不能为空",
					}
				}
			},
			"scenic.price": {
				validators: {
					notEmpty: {
						message: "门票价格不能为空",
					},
					numeric: {
						message: "门票价格不正确"
					}
				}
			},
			"scenic.openTime": {
				validators: {
					notEmpty: {
						message: "开放时间不能为空",
					}
				}
			},
			"scenic.address": {
				validators: {
					notEmpty: {
						message: "景点地址不能为空",
					}
				}
			},
		}
	}); 
	//初始化所在城市下拉框值 
	$.ajax({
		url: basePath + "City/listAll",
		type: "get",
		success: function(citys,response,status) { 
			$("#scenic_cityObj_cityNo").empty();
			var html="";
    		$(citys).each(function(i,city){
    			html += "<option value='" + city.cityNo + "'>" + city.cityName + "</option>";
    		});
    		$("#scenic_cityObj_cityNo").html(html);
    	}
	});
	//初始化景点类型下拉框值 
	$.ajax({
		url: basePath + "ScenicType/listAll",
		type: "get",
		success: function(scenicTypes,response,status) { 
			$("#scenic_scenicTypeObj_typeId").empty();
			var html="";
    		$(scenicTypes).each(function(i,scenicType){
    			html += "<option value='" + scenicType.typeId + "'>" + scenicType.typeName + "</option>";
    		});
    		$("#scenic_scenicTypeObj_typeId").html(html);
    	}
	});
})
</script>
</body>
</html>
