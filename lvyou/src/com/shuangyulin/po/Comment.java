package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Comment {
    /*评论id*/
    private Integer commentId;
    public Integer getCommentId(){
        return commentId;
    }
    public void setCommentId(Integer commentId){
        this.commentId = commentId;
    }

    /*被评景点*/
    private Scenic scenicObj;
    public Scenic getScenicObj() {
        return scenicObj;
    }
    public void setScenicObj(Scenic scenicObj) {
        this.scenicObj = scenicObj;
    }

    /*评论内容*/
    @NotEmpty(message="评论内容不能为空")
    private String commentContent;
    public String getCommentContent() {
        return commentContent;
    }
    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    /*评论人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*评论时间*/
    private String commentTime;
    public String getCommentTime() {
        return commentTime;
    }
    public void setCommentTime(String commentTime) {
        this.commentTime = commentTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonComment=new JSONObject(); 
		jsonComment.accumulate("commentId", this.getCommentId());
		jsonComment.accumulate("scenicObj", this.getScenicObj().getScenicName());
		jsonComment.accumulate("scenicObjPri", this.getScenicObj().getScenicId());
		jsonComment.accumulate("commentContent", this.getCommentContent());
		jsonComment.accumulate("userObj", this.getUserObj().getName());
		jsonComment.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonComment.accumulate("commentTime", this.getCommentTime());
		return jsonComment;
    }}