<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/scenicType.css" />
<div id="scenicType_editDiv">
	<form id="scenicTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类型id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenicType_typeId_edit" name="scenicType.typeId" value="<%=request.getParameter("typeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenicType_typeName_edit" name="scenicType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="scenicTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ScenicType/js/scenicType_modify.js"></script> 
