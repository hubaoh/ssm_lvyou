package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class OrderInfo {
    /*订单id*/
    private Integer orderId;
    public Integer getOrderId(){
        return orderId;
    }
    public void setOrderId(Integer orderId){
        this.orderId = orderId;
    }

    /*预定景点*/
    private Scenic scenicObj;
    public Scenic getScenicObj() {
        return scenicObj;
    }
    public void setScenicObj(Scenic scenicObj) {
        this.scenicObj = scenicObj;
    }

    /*预定日期*/
    @NotEmpty(message="预定日期不能为空")
    private String orderDate;
    public String getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    /*预定价格*/
    @NotNull(message="必须输入预定价格")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*预定用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*下单时间*/
    private String orderTime;
    public String getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    /*审核状态*/
    @NotEmpty(message="审核状态不能为空")
    private String shState;
    public String getShState() {
        return shState;
    }
    public void setShState(String shState) {
        this.shState = shState;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonOrderInfo=new JSONObject(); 
		jsonOrderInfo.accumulate("orderId", this.getOrderId());
		jsonOrderInfo.accumulate("scenicObj", this.getScenicObj().getScenicName());
		jsonOrderInfo.accumulate("scenicObjPri", this.getScenicObj().getScenicId());
		jsonOrderInfo.accumulate("orderDate", this.getOrderDate().length()>19?this.getOrderDate().substring(0,19):this.getOrderDate());
		jsonOrderInfo.accumulate("price", this.getPrice());
		jsonOrderInfo.accumulate("userObj", this.getUserObj().getName());
		jsonOrderInfo.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonOrderInfo.accumulate("orderTime", this.getOrderTime());
		jsonOrderInfo.accumulate("shState", this.getShState());
		return jsonOrderInfo;
    }}