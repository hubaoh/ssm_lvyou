var scenic_manage_tool = null; 
$(function () { 
	initScenicManageTool(); //建立Scenic管理对象
	scenic_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#scenic_manage").datagrid({
		url : 'Scenic/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "scenicId",
		sortOrder : "desc",
		toolbar : "#scenic_manage_tool",
		columns : [[
			{
				field : "scenicId",
				title : "景区id",
				width : 70,
			},
			{
				field : "cityObj",
				title : "所在城市",
				width : 140,
			},
			{
				field : "scenicTypeObj",
				title : "景点类型",
				width : 140,
			},
			{
				field : "dengji",
				title : "景点等级",
				width : 140,
			},
			{
				field : "scenicName",
				title : "景点名称",
				width : 140,
			},
			{
				field : "scenicPhoto",
				title : "景区图片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "price",
				title : "门票价格",
				width : 70,
			},
			{
				field : "openTime",
				title : "开放时间",
				width : 140,
			},
		]],
	});

	$("#scenicEditDiv").dialog({
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
				if ($("#scenicEditForm").form("validate")) {
					//验证表单 
					if(!$("#scenicEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#scenicEditForm").form({
						    url:"Scenic/" + $("#scenic_scenicId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#scenicEditForm").form("validate"))  {
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
			                        $("#scenicEditDiv").dialog("close");
			                        scenic_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#scenicEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#scenicEditDiv").dialog("close");
				$("#scenicEditForm").form("reset"); 
			},
		}],
	});
});

function initScenicManageTool() {
	scenic_manage_tool = {
		init: function() {
			$.ajax({
				url : "City/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#cityObj_cityNo_query").combobox({ 
					    valueField:"cityNo",
					    textField:"cityName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{cityNo:"",cityName:"不限制"});
					$("#cityObj_cityNo_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "ScenicType/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#scenicTypeObj_typeId_query").combobox({ 
					    valueField:"typeId",
					    textField:"typeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{typeId:0,typeName:"不限制"});
					$("#scenicTypeObj_typeId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#scenic_manage").datagrid("reload");
		},
		redo : function () {
			$("#scenic_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#scenic_manage").datagrid("options").queryParams;
			queryParams["cityObj.cityNo"] = $("#cityObj_cityNo_query").combobox("getValue");
			queryParams["scenicTypeObj.typeId"] = $("#scenicTypeObj_typeId_query").combobox("getValue");
			queryParams["dengji"] = $("#dengji").val();
			queryParams["scenicName"] = $("#scenicName").val();
			$("#scenic_manage").datagrid("options").queryParams=queryParams; 
			$("#scenic_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#scenicQueryForm").form({
			    url:"Scenic/OutToExcel",
			});
			//提交表单
			$("#scenicQueryForm").submit();
		},
		remove : function () {
			var rows = $("#scenic_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var scenicIds = [];
						for (var i = 0; i < rows.length; i ++) {
							scenicIds.push(rows[i].scenicId);
						}
						$.ajax({
							type : "POST",
							url : "Scenic/deletes",
							data : {
								scenicIds : scenicIds.join(","),
							},
							beforeSend : function () {
								$("#scenic_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#scenic_manage").datagrid("loaded");
									$("#scenic_manage").datagrid("load");
									$("#scenic_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#scenic_manage").datagrid("loaded");
									$("#scenic_manage").datagrid("load");
									$("#scenic_manage").datagrid("unselectAll");
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
			var rows = $("#scenic_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Scenic/" + rows[0].scenicId +  "/update",
					type : "get",
					data : {
						//scenicId : rows[0].scenicId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (scenic, response, status) {
						$.messager.progress("close");
						if (scenic) { 
							$("#scenicEditDiv").dialog("open");
							$("#scenic_scenicId_edit").val(scenic.scenicId);
							$("#scenic_scenicId_edit").validatebox({
								required : true,
								missingMessage : "请输入景区id",
								editable: false
							});
							$("#scenic_cityObj_cityNo_edit").combobox({
								url:"City/listAll",
							    valueField:"cityNo",
							    textField:"cityName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#scenic_cityObj_cityNo_edit").combobox("select", scenic.cityObjPri);
									//var data = $("#scenic_cityObj_cityNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#scenic_cityObj_cityNo_edit").combobox("select", data[0].cityNo);
						            //}
								}
							});
							$("#scenic_scenicTypeObj_typeId_edit").combobox({
								url:"ScenicType/listAll",
							    valueField:"typeId",
							    textField:"typeName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#scenic_scenicTypeObj_typeId_edit").combobox("select", scenic.scenicTypeObjPri);
									//var data = $("#scenic_scenicTypeObj_typeId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#scenic_scenicTypeObj_typeId_edit").combobox("select", data[0].typeId);
						            //}
								}
							});
							$("#scenic_dengji_edit").val(scenic.dengji);
							$("#scenic_dengji_edit").validatebox({
								required : true,
								missingMessage : "请输入景点等级",
							});
							$("#scenic_scenicName_edit").val(scenic.scenicName);
							$("#scenic_scenicName_edit").validatebox({
								required : true,
								missingMessage : "请输入景点名称",
							});
							$("#scenic_scenicPhoto").val(scenic.scenicPhoto);
							$("#scenic_scenicPhotoImg").attr("src", scenic.scenicPhoto);
							$("#scenic_scenicDesc_edit").val(scenic.scenicDesc);
							$("#scenic_scenicDesc_edit").validatebox({
								required : true,
								missingMessage : "请输入景点介绍",
							});
							$("#scenic_price_edit").val(scenic.price);
							$("#scenic_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入门票价格",
								invalidMessage : "门票价格输入不对",
							});
							$("#scenic_openTime_edit").val(scenic.openTime);
							$("#scenic_openTime_edit").validatebox({
								required : true,
								missingMessage : "请输入开放时间",
							});
							$("#scenic_address_edit").val(scenic.address);
							$("#scenic_address_edit").validatebox({
								required : true,
								missingMessage : "请输入景点地址",
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
