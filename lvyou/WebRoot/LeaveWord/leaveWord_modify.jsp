<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/leaveWord.css" />
<div id="leaveWord_editDiv">
	<form id="leaveWordEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">留言id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveWord_leaveWordId_edit" name="leaveWord.leaveWordId" value="<%=request.getParameter("leaveWordId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveWord_title_edit" name="leaveWord.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">留言内容:</span>
			<span class="inputControl">
				<textarea id="leaveWord_leaveContent_edit" name="leaveWord.leaveContent" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">留言时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveWord_addTime_edit" name="leaveWord.addTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">留言人:</span>
			<span class="inputControl">
				<input class="textbox"  id="leaveWord_userObj_user_name_edit" name="leaveWord.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">回复内容:</span>
			<span class="inputControl">
				<textarea id="leaveWord_replyContent_edit" name="leaveWord.replyContent" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">回复时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveWord_replyTime_edit" name="leaveWord.replyTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="leaveWordModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/LeaveWord/js/leaveWord_modify.js"></script> 
