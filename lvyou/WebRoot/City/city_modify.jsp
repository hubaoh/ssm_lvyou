<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/city.css" />
<div id="city_editDiv">
	<form id="cityEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">城市代码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="city_cityNo_edit" name="city.cityNo" value="<%=request.getParameter("cityNo") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">城市名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="city_cityName_edit" name="city.cityName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="cityModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/City/js/city_modify.js"></script> 
