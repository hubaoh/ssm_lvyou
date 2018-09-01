<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderInfo.css" /> 

<div id="orderInfo_manage"></div>
<div id="orderInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="orderInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="orderInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="orderInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="orderInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="orderInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="orderInfoQueryForm" method="post">
			预定景点：<input class="textbox" type="text" id="scenicObj_scenicId_query" name="scenicObj.scenicId" style="width: auto"/>
			预定日期：<input type="text" id="orderDate" name="orderDate" class="easyui-datebox" editable="false" style="width:100px">
			预定用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			审核状态：<input type="text" class="textbox" id="shState" name="shState" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="orderInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="orderInfoEditDiv">
	<form id="orderInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderId_edit" name="orderInfo.orderId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="OrderInfo/js/orderInfo_manage.js"></script> 
