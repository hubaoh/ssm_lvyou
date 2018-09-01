<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Scenic" %>
<%@ page import="com.shuangyulin.po.UserInfo" %>
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
<title>订单添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>OrderInfo/frontlist">订单列表</a></li>
			    	<li role="presentation" class="active"><a href="#orderInfoAdd" aria-controls="orderInfoAdd" role="tab" data-toggle="tab">添加订单</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="orderInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="orderInfoAdd"> 
				      	<form class="form-horizontal" name="orderInfoAddForm" id="orderInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="orderInfo_scenicObj_scenicId" class="col-md-2 text-right">预定景点:</label>
						  	 <div class="col-md-8">
							    <select id="orderInfo_scenicObj_scenicId" name="orderInfo.scenicObj.scenicId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_orderDateDiv" class="col-md-2 text-right">预定日期:</label>
						  	 <div class="col-md-8">
				                <div id="orderInfo_orderDateDiv" class="input-group date orderInfo_orderDate col-md-12" data-link-field="orderInfo_orderDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="orderInfo_orderDate" name="orderInfo.orderDate" size="16" type="text" value="" placeholder="请选择预定日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_price" class="col-md-2 text-right">预定价格:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_price" name="orderInfo.price" class="form-control" placeholder="请输入预定价格">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_userObj_user_name" class="col-md-2 text-right">预定用户:</label>
						  	 <div class="col-md-8">
							    <select id="orderInfo_userObj_user_name" name="orderInfo.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_orderTime" class="col-md-2 text-right">下单时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_orderTime" name="orderInfo.orderTime" class="form-control" placeholder="请输入下单时间">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_shState" class="col-md-2 text-right">审核状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_shState" name="orderInfo.shState" class="form-control" placeholder="请输入审核状态">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxOrderInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#orderInfoAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
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
	//提交添加订单信息
	function ajaxOrderInfoAdd() { 
		//提交之前先验证表单
		$("#orderInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#orderInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "OrderInfo/add",
			dataType : "json" , 
			data: new FormData($("#orderInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#orderInfoAddForm").find("input").val("");
					$("#orderInfoAddForm").find("textarea").val("");
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
	//验证订单添加表单字段
	$('#orderInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"orderInfo.orderDate": {
				validators: {
					notEmpty: {
						message: "预定日期不能为空",
					}
				}
			},
			"orderInfo.price": {
				validators: {
					notEmpty: {
						message: "预定价格不能为空",
					},
					numeric: {
						message: "预定价格不正确"
					}
				}
			},
			"orderInfo.shState": {
				validators: {
					notEmpty: {
						message: "审核状态不能为空",
					}
				}
			},
		}
	}); 
	//初始化预定景点下拉框值 
	$.ajax({
		url: basePath + "Scenic/listAll",
		type: "get",
		success: function(scenics,response,status) { 
			$("#orderInfo_scenicObj_scenicId").empty();
			var html="";
    		$(scenics).each(function(i,scenic){
    			html += "<option value='" + scenic.scenicId + "'>" + scenic.scenicName + "</option>";
    		});
    		$("#orderInfo_scenicObj_scenicId").html(html);
    	}
	});
	//初始化预定用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#orderInfo_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#orderInfo_userObj_user_name").html(html);
    	}
	});
	//预定日期组件
	$('#orderInfo_orderDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#orderInfoAddForm').data('bootstrapValidator').updateStatus('orderInfo.orderDate', 'NOT_VALIDATED',null).validateField('orderInfo.orderDate');
	});
})
</script>
</body>
</html>
