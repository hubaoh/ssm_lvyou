var city_manage_tool = null; 
$(function () { 
	initCityManageTool(); //建立City管理对象
	city_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#city_manage").datagrid({
		url : 'City/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "cityNo",
		sortOrder : "desc",
		toolbar : "#city_manage_tool",
		columns : [[
			{
				field : "cityNo",
				title : "城市代码",
				width : 140,
			},
			{
				field : "cityName",
				title : "城市名称",
				width : 140,
			},
		]],
	});

	$("#cityEditDiv").dialog({
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
				if ($("#cityEditForm").form("validate")) {
					//验证表单 
					if(!$("#cityEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#cityEditForm").form({
						    url:"City/" + $("#city_cityNo_edit").val() + "/update",
						    onSubmit: function(){
								if($("#cityEditForm").form("validate"))  {
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
			                        $("#cityEditDiv").dialog("close");
			                        city_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#cityEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#cityEditDiv").dialog("close");
				$("#cityEditForm").form("reset"); 
			},
		}],
	});
});

function initCityManageTool() {
	city_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#city_manage").datagrid("reload");
		},
		redo : function () {
			$("#city_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#city_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#cityQueryForm").form({
			    url:"City/OutToExcel",
			});
			//提交表单
			$("#cityQueryForm").submit();
		},
		remove : function () {
			var rows = $("#city_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var cityNos = [];
						for (var i = 0; i < rows.length; i ++) {
							cityNos.push(rows[i].cityNo);
						}
						$.ajax({
							type : "POST",
							url : "City/deletes",
							data : {
								cityNos : cityNos.join(","),
							},
							beforeSend : function () {
								$("#city_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#city_manage").datagrid("loaded");
									$("#city_manage").datagrid("load");
									$("#city_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#city_manage").datagrid("loaded");
									$("#city_manage").datagrid("load");
									$("#city_manage").datagrid("unselectAll");
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
			var rows = $("#city_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "City/" + rows[0].cityNo +  "/update",
					type : "get",
					data : {
						//cityNo : rows[0].cityNo,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (city, response, status) {
						$.messager.progress("close");
						if (city) { 
							$("#cityEditDiv").dialog("open");
							$("#city_cityNo_edit").val(city.cityNo);
							$("#city_cityNo_edit").validatebox({
								required : true,
								missingMessage : "请输入城市代码",
								editable: false
							});
							$("#city_cityName_edit").val(city.cityName);
							$("#city_cityName_edit").validatebox({
								required : true,
								missingMessage : "请输入城市名称",
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
