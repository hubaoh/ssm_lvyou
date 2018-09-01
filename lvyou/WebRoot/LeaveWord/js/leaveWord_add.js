$(function () {
	$("#leaveWord_title").validatebox({
		required : true, 
		missingMessage : '请输入标题',
	});

	$("#leaveWord_leaveContent").validatebox({
		required : true, 
		missingMessage : '请输入留言内容',
	});

	$("#leaveWord_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#leaveWord_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#leaveWord_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	//单击添加按钮
	$("#leaveWordAddButton").click(function () {
		//验证表单 
		if(!$("#leaveWordAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#leaveWordAddForm").form({
			    url:"LeaveWord/add",
			    onSubmit: function(){
					if($("#leaveWordAddForm").form("validate"))  { 
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
                        $("#leaveWordAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#leaveWordAddForm").submit();
		}
	});

	//单击清空按钮
	$("#leaveWordClearButton").click(function () { 
		$("#leaveWordAddForm").form("clear"); 
	});
});
