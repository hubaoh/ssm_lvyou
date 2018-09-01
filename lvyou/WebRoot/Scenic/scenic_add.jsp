<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/scenic.css" />
<div id="scenicAddDiv">
	<form id="scenicAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">所在城市:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_cityObj_cityNo" name="scenic.cityObj.cityNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">景点类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_scenicTypeObj_typeId" name="scenic.scenicTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">景点等级:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_dengji" name="scenic.dengji" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">景点名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_scenicName" name="scenic.scenicName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">景区图片:</span>
			<span class="inputControl">
				<input id="scenicPhotoFile" name="scenicPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">景点介绍:</span>
			<span class="inputControl">
				<textarea id="scenic_scenicDesc" name="scenic.scenicDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">门票价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_price" name="scenic.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">开放时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_openTime" name="scenic.openTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">景点地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_address" name="scenic.address" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="scenicAddButton" class="easyui-linkbutton">添加</a>
			<a id="scenicClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Scenic/js/scenic_add.js"></script> 
