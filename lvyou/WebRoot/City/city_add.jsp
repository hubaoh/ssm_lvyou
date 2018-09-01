<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/city.css" />
<div id="cityAddDiv">
	<form id="cityAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">城市代码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="city_cityNo" name="city.cityNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">城市名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="city_cityName" name="city.cityName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="cityAddButton" class="easyui-linkbutton">添加</a>
			<a id="cityClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/City/js/city_add.js"></script> 
