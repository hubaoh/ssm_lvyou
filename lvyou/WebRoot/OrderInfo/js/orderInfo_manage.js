var orderInfo_manage_tool = null; 
$(function () { 
	initOrderInfoManageTool(); //建立OrderInfo管理对象
	orderInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#orderInfo_manage").datagrid({
		url : 'OrderInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "orderId",
		sortOrder : "desc",
		toolbar : "#orderInfo_manage_tool",
		columns : [[
			{
				field : "orderId",
				title : "订单id",
				width : 70,
			},
			{
				field : "scenicObj",
				title : "预定景点",
				width : 140,
			},
			{
				field : "orderDate",
				title : "预定日期",
				width : 140,
			},
			{
				field : "price",
				title : "预定价格",
				width : 70,
			},
			{
				field : "userObj",
				title : "预定用户",
				width : 140,
			},
			{
				field : "orderTime",
				title : "下单时间",
				width : 140,
			},
			{
				field : "shState",
				title : "审核状态",
				width : 140,
			},
		]],
	});

	$("#orderInfoEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#orderInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#orderInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#orderInfoEditForm").form({
						    url:"OrderInfo/" + $("#orderInfo_orderId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#orderInfoEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#orderInfoEditDiv").dialog("close");
			                        orderInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#orderInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#orderInfoEditDiv").dialog("close");
				$("#orderInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initOrderInfoManageTool() {
	orderInfo_manage_tool = {
		init: function() {
			$.ajax({
				url : "Scenic/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#scenicObj_scenicId_query").combobox({ 
					    valueField:"scenicId",
					    textField:"scenicName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{scenicId:0,scenicName:"不限制"});
					$("#scenicObj_scenicId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#orderInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#orderInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#orderInfo_manage").datagrid("options").queryParams;
			queryParams["scenicObj.scenicId"] = $("#scenicObj_scenicId_query").combobox("getValue");
			queryParams["orderDate"] = $("#orderDate").datebox("getValue"); 
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["shState"] = $("#shState").val();
			$("#orderInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#orderInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#orderInfoQueryForm").form({
			    url:"OrderInfo/OutToExcel",
			});
			//提交表单
			$("#orderInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#orderInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var orderIds = [];
						for (var i = 0; i < rows.length; i ++) {
							orderIds.push(rows[i].orderId);
						}
						$.ajax({
							type : "POST",
							url : "OrderInfo/deletes",
							data : {
								orderIds : orderIds.join(","),
							},
							beforeSend : function () {
								$("#orderInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#orderInfo_manage").datagrid("loaded");
									$("#orderInfo_manage").datagrid("load");
									$("#orderInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#orderInfo_manage").datagrid("loaded");
									$("#orderInfo_manage").datagrid("load");
									$("#orderInfo_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#orderInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "OrderInfo/" + rows[0].orderId +  "/update",
					type : "get",
					data : {
						//orderId : rows[0].orderId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (orderInfo, response, status) {
						$.messager.progress("close");
						if (orderInfo) { 
							$("#orderInfoEditDiv").dialog("open");
							$("#orderInfo_orderId_edit").val(orderInfo.orderId);
							$("#orderInfo_orderId_edit").validatebox({
								required : true,
								missingMessage : "请输入订单id",
								editable: false
							});
							$("#orderInfo_scenicObj_scenicId_edit").combobox({
								url:"Scenic/listAll",
							    valueField:"scenicId",
							    textField:"scenicName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#orderInfo_scenicObj_scenicId_edit").combobox("select", orderInfo.scenicObjPri);
									//var data = $("#orderInfo_scenicObj_scenicId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#orderInfo_scenicObj_scenicId_edit").combobox("select", data[0].scenicId);
						            //}
								}
							});
							$("#orderInfo_orderDate_edit").datebox({
								value: orderInfo.orderDate,
							    required: true,
							    showSeconds: true,
							});
							$("#orderInfo_price_edit").val(orderInfo.price);
							$("#orderInfo_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入预定价格",
								invalidMessage : "预定价格输入不对",
							});
							$("#orderInfo_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#orderInfo_userObj_user_name_edit").combobox("select", orderInfo.userObjPri);
									//var data = $("#orderInfo_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#orderInfo_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#orderInfo_orderTime_edit").val(orderInfo.orderTime);
							$("#orderInfo_shState_edit").val(orderInfo.shState);
							$("#orderInfo_shState_edit").validatebox({
								required : true,
								missingMessage : "请输入审核状态",
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
