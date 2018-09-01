package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Scenic {
    /*景区id*/
    private Integer scenicId;
    public Integer getScenicId(){
        return scenicId;
    }
    public void setScenicId(Integer scenicId){
        this.scenicId = scenicId;
    }

    /*所在城市*/
    private City cityObj;
    public City getCityObj() {
        return cityObj;
    }
    public void setCityObj(City cityObj) {
        this.cityObj = cityObj;
    }

    /*景点类型*/
    private ScenicType scenicTypeObj;
    public ScenicType getScenicTypeObj() {
        return scenicTypeObj;
    }
    public void setScenicTypeObj(ScenicType scenicTypeObj) {
        this.scenicTypeObj = scenicTypeObj;
    }

    /*景点等级*/
    @NotEmpty(message="景点等级不能为空")
    private String dengji;
    public String getDengji() {
        return dengji;
    }
    public void setDengji(String dengji) {
        this.dengji = dengji;
    }

    /*景点名称*/
    @NotEmpty(message="景点名称不能为空")
    private String scenicName;
    public String getScenicName() {
        return scenicName;
    }
    public void setScenicName(String scenicName) {
        this.scenicName = scenicName;
    }

    /*景区图片*/
    private String scenicPhoto;
    public String getScenicPhoto() {
        return scenicPhoto;
    }
    public void setScenicPhoto(String scenicPhoto) {
        this.scenicPhoto = scenicPhoto;
    }

    /*景点介绍*/
    @NotEmpty(message="景点介绍不能为空")
    private String scenicDesc;
    public String getScenicDesc() {
        return scenicDesc;
    }
    public void setScenicDesc(String scenicDesc) {
        this.scenicDesc = scenicDesc;
    }

    /*门票价格*/
    @NotNull(message="必须输入门票价格")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*开放时间*/
    @NotEmpty(message="开放时间不能为空")
    private String openTime;
    public String getOpenTime() {
        return openTime;
    }
    public void setOpenTime(String openTime) {
        this.openTime = openTime;
    }

    /*景点地址*/
    @NotEmpty(message="景点地址不能为空")
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonScenic=new JSONObject(); 
		jsonScenic.accumulate("scenicId", this.getScenicId());
		jsonScenic.accumulate("cityObj", this.getCityObj().getCityName());
		jsonScenic.accumulate("cityObjPri", this.getCityObj().getCityNo());
		jsonScenic.accumulate("scenicTypeObj", this.getScenicTypeObj().getTypeName());
		jsonScenic.accumulate("scenicTypeObjPri", this.getScenicTypeObj().getTypeId());
		jsonScenic.accumulate("dengji", this.getDengji());
		jsonScenic.accumulate("scenicName", this.getScenicName());
		jsonScenic.accumulate("scenicPhoto", this.getScenicPhoto());
		jsonScenic.accumulate("scenicDesc", this.getScenicDesc());
		jsonScenic.accumulate("price", this.getPrice());
		jsonScenic.accumulate("openTime", this.getOpenTime());
		jsonScenic.accumulate("address", this.getAddress());
		return jsonScenic;
    }}