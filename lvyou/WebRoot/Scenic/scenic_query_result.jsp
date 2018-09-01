<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/scenic.css" /> 

<div id="scenic_manage"></div>
<div id="scenic_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="scenic_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="scenic_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="scenic_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="scenic_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="scenic_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="scenicQueryForm" method="post">
			所在城市：<input class="textbox" type="text" id="cityObj_cityNo_query" name="cityObj.cityNo" style="width: auto"/>
			景点类型：<input class="textbox" type="text" id="scenicTypeObj_typeId_query" name="scenicTypeObj.typeId" style="width: auto"/>
			景点等级：<input type="text" class="textbox" id="dengji" name="dengji" style="width:110px" />
			景点名称：<input type="text" class="textbox" id="scenicName" name="scenicName" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="scenic_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="scenicEditDiv">
	<form id="scenicEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">景区id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_scenicId_edit" name="scenic.scenicId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">所在城市:</span>
			<span class="inputControl">
				<input class="textbox"  id="scenic_cityObj_cityNo_edit" name="scenic.cityObj.cityNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">景点类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="scenic_scenicTypeObj_typeId_edit" name="scenic.scenicTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">景点等级:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_dengji_edit" name="scenic.dengji" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">景点名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_scenicName_edit" name="scenic.scenicName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">景区图片:</span>
			<span class="inputControl">
				<img id="scenic_scenicPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="scenic_scenicPhoto" name="scenic.scenicPhoto"/>
				<input id="scenicPhotoFile" name="scenicPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">景点介绍:</span>
			<span class="inputControl">
				<textarea id="scenic_scenicDesc_edit" name="scenic.scenicDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">门票价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_price_edit" name="scenic.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">开放时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_openTime_edit" name="scenic.openTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">景点地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="scenic_address_edit" name="scenic.address" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Scenic/js/scenic_manage.js"></script> 
