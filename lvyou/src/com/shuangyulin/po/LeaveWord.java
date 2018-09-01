package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class LeaveWord {
    /*留言id*/
    private Integer leaveWordId;
    public Integer getLeaveWordId(){
        return leaveWordId;
    }
    public void setLeaveWordId(Integer leaveWordId){
        this.leaveWordId = leaveWordId;
    }

    /*标题*/
    @NotEmpty(message="标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*留言内容*/
    @NotEmpty(message="留言内容不能为空")
    private String leaveContent;
    public String getLeaveContent() {
        return leaveContent;
    }
    public void setLeaveContent(String leaveContent) {
        this.leaveContent = leaveContent;
    }

    /*留言时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    /*留言人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*回复内容*/
    private String replyContent;
    public String getReplyContent() {
        return replyContent;
    }
    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    /*回复时间*/
    private String replyTime;
    public String getReplyTime() {
        return replyTime;
    }
    public void setReplyTime(String replyTime) {
        this.replyTime = replyTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonLeaveWord=new JSONObject(); 
		jsonLeaveWord.accumulate("leaveWordId", this.getLeaveWordId());
		jsonLeaveWord.accumulate("title", this.getTitle());
		jsonLeaveWord.accumulate("leaveContent", this.getLeaveContent());
		jsonLeaveWord.accumulate("addTime", this.getAddTime());
		jsonLeaveWord.accumulate("userObj", this.getUserObj().getName());
		jsonLeaveWord.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonLeaveWord.accumulate("replyContent", this.getReplyContent());
		jsonLeaveWord.accumulate("replyTime", this.getReplyTime());
		return jsonLeaveWord;
    }}