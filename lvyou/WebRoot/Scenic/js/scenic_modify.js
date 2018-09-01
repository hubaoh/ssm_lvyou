$(function () {
	$.ajax({
		url : "Scenic/" + $("#scenic_scenicId_edit").val() + "/update",
		type : "get",
		data : {
			//scenicId : $("#scenic_scenicId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (scenic, response, status) {
			$.messager.progress("close");
			if (scenic) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#scenicModifyButton").click(function(){ 
		if ($("#scenicEditForm").form("validate")) {
			$("#scenicEditForm").form({
			    url:"Scenic/" +  $("#scenic_scenicId_edit").val() + "/update",
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
			$("#scenicEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
