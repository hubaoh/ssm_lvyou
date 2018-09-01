$(function () {
	$("#orderInfo_scenicObj_scenicId").combobox({
	    url:'Scenic/listAll',
	    valueField: "scenicId",
	    textField: "scenicName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#orderInfo_scenicObj_scenicId").combobox("getData"); 
            if (data.length > 0) {
                $("#orderInfo_scenicObj_scenicId").combobox("select", data[0].scenicId);
            }
        }
	});
	$("#orderInfo_orderDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#orderInfo_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入预定价格',
		invalidMessage : '预定价格输入不对',
	});

	$("#orderInfo_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#orderInfo_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#orderInfo_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#orderInfo_shState").validatebox({
		required : true, 
		missingMessage : '请输入审核状态',
	});

	//单击添加按钮
	$("#orderInfoAddButton").click(function () {
		//验证表单 
		if(!$("#orderInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#orderInfoAddForm").form({
			    url:"OrderInfo/add",
			    onSubmit: function(){
					if($("#orderInfoAddForm").form("validate"))  { 
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
                        $("#orderInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#orderInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#orderInfoClearButton").click(function () { 
		$("#orderInfoAddForm").form("clear"); 
	});
});
