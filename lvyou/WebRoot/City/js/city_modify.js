$(function () {
	$.ajax({
		url : "City/" + $("#city_cityNo_edit").val() + "/update",
		type : "get",
		data : {
			//cityNo : $("#city_cityNo_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (city, response, status) {
			$.messager.progress("close");
			if (city) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#cityModifyButton").click(function(){ 
		if ($("#cityEditForm").form("validate")) {
			$("#cityEditForm").form({
			    url:"City/" +  $("#city_cityNo_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#cityEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
