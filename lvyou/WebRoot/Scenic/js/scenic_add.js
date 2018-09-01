$(function () {
	$("#scenic_cityObj_cityNo").combobox({
	    url:'City/listAll',
	    valueField: "cityNo",
	    textField: "cityName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#scenic_cityObj_cityNo").combobox("getData"); 
            if (data.length > 0) {
                $("#scenic_cityObj_cityNo").combobox("select", data[0].cityNo);
            }
        }
	});
	$("#scenic_scenicTypeObj_typeId").combobox({
	    url:'ScenicType/listAll',
	    valueField: "typeId",
	    textField: "typeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#scenic_scenicTypeObj_typeId").combobox("getData"); 
            if (data.length > 0) {
                $("#scenic_scenicTypeObj_typeId").combobox("select", data[0].typeId);
            }
        }
	});
	$("#scenic_dengji").validatebox({
		required : true, 
		missingMessage : '请输入景点等级',
	});

	$("#scenic_scenicName").validatebox({
		required : true, 
		missingMessage : '请输入景点名称',
	});

	$("#scenic_scenicDesc").validatebox({
		required : true, 
		missingMessage : '请输入景点介绍',
	});

	$("#scenic_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入门票价格',
		invalidMessage : '门票价格输入不对',
	});

	$("#scenic_openTime").validatebox({
		required : true, 
		missingMessage : '请输入开放时间',
	});

	$("#scenic_address").validatebox({
		required : true, 
		missingMessage : '请输入景点地址',
	});

	//单击添加按钮
	$("#scenicAddButton").click(function () {
		//验证表单 
		if(!$("#scenicAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#scenicAddForm").form({
			    url:"Scenic/add",
			    onSubmit: function(){
					if($("#scenicAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#scenicAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#scenicAddForm").submit();
		}
	});

	//单击清空按钮
	$("#scenicClearButton").click(function () { 
		$("#scenicAddForm").form("clear"); 
	});
});
