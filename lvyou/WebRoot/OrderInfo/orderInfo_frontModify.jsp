<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.OrderInfo" %>
<%@ page import="com.shuangyulin.po.Scenic" %>
<%@ page import="com.shuangyulin.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的scenicObj信息
    List<Scenic> scenicList = (List<Scenic>)request.getAttribute("scenicList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    OrderInfo orderInfo = (OrderInfo)request.getAttribute("orderInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改订单信息</TITLE>
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
  		<li class="active">订单信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="orderInfoEditForm" id="orderInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="orderInfo_orderId_edit" class="col-md-3 text-right">订单id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="orderInfo_orderId_edit" name="orderInfo.orderId" class="form-control" placeholder="请输入订单id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="orderInfo_scenicObj_scenicId_edit" class="col-md-3 text-right">预定景点:</label>
		  	 <div class="col-md-9">
			    <select id="orderInfo_scenicObj_scenicId_edit" name="orderInfo.scenicObj.scenicId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_orderDate_edit" class="col-md-3 text-right">预定日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date orderInfo_orderDate_edit col-md-12" data-link-field="orderInfo_orderDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="orderInfo_orderDate_edit" name="orderInfo.orderDate" size="16" type="text" value="" placeholder="请选择预定日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_price_edit" class="col-md-3 text-right">预定价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_price_edit" name="orderInfo.price" class="form-control" placeholder="请输入预定价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_userObj_user_name_edit" class="col-md-3 text-right">预定用户:</label>
		  	 <div class="col-md-9">
			    <select id="orderInfo_userObj_user_name_edit" name="orderInfo.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_orderTime_edit" class="col-md-3 text-right">下单时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_orderTime_edit" name="orderInfo.orderTime" class="form-control" placeholder="请输入下单时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="orderInfo_shState_edit" class="col-md-3 text-right">审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="orderInfo_shState_edit" name="orderInfo.shState" class="form-control" placeholder="请输入审核状态">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxOrderInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#orderInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改订单界面并初始化数据*/
function orderInfoEdit(orderId) {
	$.ajax({
		url :  basePath + "OrderInfo/" + orderId + "/update",
		type : "get",
		dataType: "json",
		success : function (orderInfo, response, status) {
			if (orderInfo) {
				$("#orderInfo_orderId_edit").val(orderInfo.orderId);
				$.ajax({
					url: basePath + "Scenic/listAll",
					type: "get",
					success: function(scenics,response,status) { 
						$("#orderInfo_scenicObj_scenicId_edit").empty();
						var html="";
		        		$(scenics).each(function(i,scenic){
		        			html += "<option value='" + scenic.scenicId + "'>" + scenic.scenicName + "</option>";
		        		});
		        		$("#orderInfo_scenicObj_scenicId_edit").html(html);
		        		$("#orderInfo_scenicObj_scenicId_edit").val(orderInfo.scenicObjPri);
					}
				});
				$("#orderInfo_orderDate_edit").val(orderInfo.orderDate);
				$("#orderInfo_price_edit").val(orderInfo.price);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#orderInfo_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#orderInfo_userObj_user_name_edit").html(html);
		        		$("#orderInfo_userObj_user_name_edit").val(orderInfo.userObjPri);
					}
				});
				$("#orderInfo_orderTime_edit").val(orderInfo.orderTime);
				$("#orderInfo_shState_edit").val(orderInfo.shState);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交订单信息表单给服务器端修改*/
function ajaxOrderInfoModify() {
	$.ajax({
		url :  basePath + "OrderInfo/" + $("#orderInfo_orderId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#orderInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#orderInfoQueryForm").submit();
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
    /*预定日期组件*/
    $('.orderInfo_orderDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    orderInfoEdit("<%=request.getParameter("orderId")%>");
 })
 </script> 
</body>
</html>

