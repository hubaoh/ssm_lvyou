<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderInfo.css" />
<div id="orderInfoAddDiv">
	<form id="orderInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">预定景点:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_scenicObj_scenicId" name="orderInfo.scenicObj.scenicId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预定日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderDate" name="orderInfo.orderDate" />

			</span>

		</div>
		<div>
			<span class="label">预定价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_price" name="orderInfo.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">预定用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_userObj_user_name" name="orderInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">下单时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderTime" name="orderInfo.orderTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_shState" name="orderInfo.shState" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="orderInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="orderInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/OrderInfo/js/orderInfo_add.js"></script> 
