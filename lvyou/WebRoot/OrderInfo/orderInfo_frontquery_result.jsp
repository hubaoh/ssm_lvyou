<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.OrderInfo" %>
<%@ page import="com.shuangyulin.po.Scenic" %>
<%@ page import="com.shuangyulin.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<OrderInfo> orderInfoList = (List<OrderInfo>)request.getAttribute("orderInfoList");
    //获取所有的scenicObj信息
    List<Scenic> scenicList = (List<Scenic>)request.getAttribute("scenicList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Scenic scenicObj = (Scenic)request.getAttribute("scenicObj");
    String orderDate = (String)request.getAttribute("orderDate"); //预定日期查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String shState = (String)request.getAttribute("shState"); //审核状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>订单查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#orderInfoListPanel" aria-controls="orderInfoListPanel" role="tab" data-toggle="tab">订单列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>OrderInfo/orderInfo_frontAdd.jsp" style="display:none;">添加订单</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="orderInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>订单id</td><td>预定景点</td><td>预定日期</td><td>预定价格</td><td>预定用户</td><td>下单时间</td><td>审核状态</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<orderInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		OrderInfo orderInfo = orderInfoList.get(i); //获取到订单对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=orderInfo.getOrderId() %></td>
 											<td><%=orderInfo.getScenicObj().getScenicName() %></td>
 											<td><%=orderInfo.getOrderDate() %></td>
 											<td><%=orderInfo.getPrice() %></td>
 											<td><%=orderInfo.getUserObj().getName() %></td>
 											<td><%=orderInfo.getOrderTime() %></td>
 											<td><%=orderInfo.getShState() %></td>
 											<td>
 												<a href="<%=basePath  %>OrderInfo/<%=orderInfo.getOrderId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="orderInfoEdit('<%=orderInfo.getOrderId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="orderInfoDelete('<%=orderInfo.getOrderId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>订单查询</h1>
		</div>
		<form name="orderInfoQueryForm" id="orderInfoQueryForm" action="<%=basePath %>OrderInfo/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="scenicObj_scenicId">预定景点：</label>
                <select id="scenicObj_scenicId" name="scenicObj.scenicId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Scenic scenicTemp:scenicList) {
	 					String selected = "";
 					if(scenicObj!=null && scenicObj.getScenicId()!=null && scenicObj.getScenicId().intValue()==scenicTemp.getScenicId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=scenicTemp.getScenicId() %>" <%=selected %>><%=scenicTemp.getScenicName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="orderDate">预定日期:</label>
				<input type="text" id="orderDate" name="orderDate" class="form-control"  placeholder="请选择预定日期" value="<%=orderDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <div class="form-group">
            	<label for="userObj_user_name">预定用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="shState">审核状态:</label>
				<input type="text" id="shState" name="shState" value="<%=shState %>" class="form-control" placeholder="请输入审核状态">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="orderInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;订单信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date orderInfo_orderDate_edit col-md-12" data-link-field="orderInfo_orderDate_edit"  data-link-format="yyyy-mm-dd">
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
		</form> 
	    <style>#orderInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxOrderInfoModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.orderInfoQueryForm.currentPage.value = currentPage;
    document.orderInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.orderInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.orderInfoQueryForm.currentPage.value = pageValue;
    documentorderInfoQueryForm.submit();
}

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
				$('#orderInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除订单信息*/
function orderInfoDelete(orderId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "OrderInfo/deletes",
			data : {
				orderIds : orderId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#orderInfoQueryForm").submit();
					//location.href= basePath + "OrderInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

