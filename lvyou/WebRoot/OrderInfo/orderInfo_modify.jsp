<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderInfo.css" />
<div id="orderInfo_editDiv">
	<form id="orderInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderId_edit" name="orderInfo.orderId" value="<%=request.getParameter("orderId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">预定景点:</span>
			<span class="inputControl">
				<input class="textbox"  id="orderInfo_scenicObj_scenicId_edit" name="orderInfo.scenicObj.scenicId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预定日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderDate_edit" name="orderInfo.orderDate" />

			</span>

		</div>
		<div>
			<span class="label">预定价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_price_edit" name="orderInfo.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">预定用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="orderInfo_userObj_user_name_edit" name="orderInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">下单时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderTime_edit" name="orderInfo.orderTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_shState_edit" name="orderInfo.shState" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="orderInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/OrderInfo/js/orderInfo_modify.js"></script> 
