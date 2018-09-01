<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/scenicType.css" />
<div id="scenicTypeAddDiv">
	<form id="scenicTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenicType_typeName" name="scenicType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="scenicTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="scenicTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ScenicType/js/scenicType_add.js"></script> 
