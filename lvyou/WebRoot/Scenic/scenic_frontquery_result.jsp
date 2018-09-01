<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Scenic" %>
<%@ page import="com.shuangyulin.po.City" %>
<%@ page import="com.shuangyulin.po.ScenicType" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Scenic> scenicList = (List<Scenic>)request.getAttribute("scenicList");
    //获取所有的cityObj信息
    List<City> cityList = (List<City>)request.getAttribute("cityList");
    //获取所有的scenicTypeObj信息
    List<ScenicType> scenicTypeList = (List<ScenicType>)request.getAttribute("scenicTypeList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    City cityObj = (City)request.getAttribute("cityObj");
    ScenicType scenicTypeObj = (ScenicType)request.getAttribute("scenicTypeObj");
    String dengji = (String)request.getAttribute("dengji"); //景点等级查询关键字
    String scenicName = (String)request.getAttribute("scenicName"); //景点名称查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>景点查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Scenic/frontlist">景点信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Scenic/scenic_frontAdd.jsp" style="display:none;">添加景点</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<scenicList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Scenic scenic = scenicList.get(i); //获取到景点对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Scenic/<%=scenic.getScenicId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=scenic.getScenicPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		景区id:<%=scenic.getScenicId() %>
			     	</div>
			     	<div class="field">
	            		所在城市:<%=scenic.getCityObj().getCityName() %>
			     	</div>
			     	<div class="field">
	            		景点类型:<%=scenic.getScenicTypeObj().getTypeName() %>
			     	</div>
			     	<div class="field">
	            		景点等级:<%=scenic.getDengji() %>
			     	</div>
			     	<div class="field">
	            		景点名称:<%=scenic.getScenicName() %>
			     	</div>
			     	<div class="field">
	            		门票价格:<%=scenic.getPrice() %>
			     	</div>
			     	<div class="field">
	            		开放时间:<%=scenic.getOpenTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Scenic/<%=scenic.getScenicId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="scenicEdit('<%=scenic.getScenicId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="scenicDelete('<%=scenic.getScenicId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>景点查询</h1>
		</div>
		<form name="scenicQueryForm" id="scenicQueryForm" action="<%=basePath %>Scenic/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="cityObj_cityNo">所在城市：</label>
                <select id="cityObj_cityNo" name="cityObj.cityNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(City cityTemp:cityList) {
	 					String selected = "";
 					if(cityObj!=null && cityObj.getCityNo()!=null && cityObj.getCityNo().equals(cityTemp.getCityNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=cityTemp.getCityNo() %>" <%=selected %>><%=cityTemp.getCityName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="scenicTypeObj_typeId">景点类型：</label>
                <select id="scenicTypeObj_typeId" name="scenicTypeObj.typeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(ScenicType scenicTypeTemp:scenicTypeList) {
	 					String selected = "";
 					if(scenicTypeObj!=null && scenicTypeObj.getTypeId()!=null && scenicTypeObj.getTypeId().intValue()==scenicTypeTemp.getTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=scenicTypeTemp.getTypeId() %>" <%=selected %>><%=scenicTypeTemp.getTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="dengji">景点等级:</label>
				<input type="text" id="dengji" name="dengji" value="<%=dengji %>" class="form-control" placeholder="请输入景点等级">
			</div>
			<div class="form-group">
				<label for="scenicName">景点名称:</label>
				<input type="text" id="scenicName" name="scenicName" value="<%=scenicName %>" class="form-control" placeholder="请输入景点名称">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="scenicEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;景点信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="scenicEditForm" id="scenicEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="scenic_scenicId_edit" class="col-md-3 text-right">景区id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="scenic_scenicId_edit" name="scenic.scenicId" class="form-control" placeholder="请输入景区id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="scenic_cityObj_cityNo_edit" class="col-md-3 text-right">所在城市:</label>
		  	 <div class="col-md-9">
			    <select id="scenic_cityObj_cityNo_edit" name="scenic.cityObj.cityNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_scenicTypeObj_typeId_edit" class="col-md-3 text-right">景点类型:</label>
		  	 <div class="col-md-9">
			    <select id="scenic_scenicTypeObj_typeId_edit" name="scenic.scenicTypeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_dengji_edit" class="col-md-3 text-right">景点等级:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scenic_dengji_edit" name="scenic.dengji" class="form-control" placeholder="请输入景点等级">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_scenicName_edit" class="col-md-3 text-right">景点名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scenic_scenicName_edit" name="scenic.scenicName" class="form-control" placeholder="请输入景点名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_scenicPhoto_edit" class="col-md-3 text-right">景区图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="scenic_scenicPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="scenic_scenicPhoto" name="scenic.scenicPhoto"/>
			    <input id="scenicPhotoFile" name="scenicPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_scenicDesc_edit" class="col-md-3 text-right">景点介绍:</label>
		  	 <div class="col-md-9">
			    <textarea id="scenic_scenicDesc_edit" name="scenic.scenicDesc" rows="8" class="form-control" placeholder="请输入景点介绍"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_price_edit" class="col-md-3 text-right">门票价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scenic_price_edit" name="scenic.price" class="form-control" placeholder="请输入门票价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_openTime_edit" class="col-md-3 text-right">开放时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scenic_openTime_edit" name="scenic.openTime" class="form-control" placeholder="请输入开放时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="scenic_address_edit" class="col-md-3 text-right">景点地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="scenic_address_edit" name="scenic.address" class="form-control" placeholder="请输入景点地址">
			 </div>
		  </div>
		</form> 
	    <style>#scenicEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxScenicModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.scenicQueryForm.currentPage.value = currentPage;
    document.scenicQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.scenicQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.scenicQueryForm.currentPage.value = pageValue;
    documentscenicQueryForm.submit();
}

/*弹出修改景点界面并初始化数据*/
function scenicEdit(scenicId) {
	$.ajax({
		url :  basePath + "Scenic/" + scenicId + "/update",
		type : "get",
		dataType: "json",
		success : function (scenic, response, status) {
			if (scenic) {
				$("#scenic_scenicId_edit").val(scenic.scenicId);
				$.ajax({
					url: basePath + "City/listAll",
					type: "get",
					success: function(citys,response,status) { 
						$("#scenic_cityObj_cityNo_edit").empty();
						var html="";
		        		$(citys).each(function(i,city){
		        			html += "<option value='" + city.cityNo + "'>" + city.cityName + "</option>";
		        		});
		        		$("#scenic_cityObj_cityNo_edit").html(html);
		        		$("#scenic_cityObj_cityNo_edit").val(scenic.cityObjPri);
					}
				});
				$.ajax({
					url: basePath + "ScenicType/listAll",
					type: "get",
					success: function(scenicTypes,response,status) { 
						$("#scenic_scenicTypeObj_typeId_edit").empty();
						var html="";
		        		$(scenicTypes).each(function(i,scenicType){
		        			html += "<option value='" + scenicType.typeId + "'>" + scenicType.typeName + "</option>";
		        		});
		        		$("#scenic_scenicTypeObj_typeId_edit").html(html);
		        		$("#scenic_scenicTypeObj_typeId_edit").val(scenic.scenicTypeObjPri);
					}
				});
				$("#scenic_dengji_edit").val(scenic.dengji);
				$("#scenic_scenicName_edit").val(scenic.scenicName);
				$("#scenic_scenicPhoto").val(scenic.scenicPhoto);
				$("#scenic_scenicPhotoImg").attr("src", basePath +　scenic.scenicPhoto);
				$("#scenic_scenicDesc_edit").val(scenic.scenicDesc);
				$("#scenic_price_edit").val(scenic.price);
				$("#scenic_openTime_edit").val(scenic.openTime);
				$("#scenic_address_edit").val(scenic.address);
				$('#scenicEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除景点信息*/
function scenicDelete(scenicId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Scenic/deletes",
			data : {
				scenicIds : scenicId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#scenicQueryForm").submit();
					//location.href= basePath + "Scenic/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交景点信息表单给服务器端修改*/
function ajaxScenicModify() {
	$.ajax({
		url :  basePath + "Scenic/" + $("#scenic_scenicId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#scenicEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#scenicQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

})
</script>
</body>
</html>

