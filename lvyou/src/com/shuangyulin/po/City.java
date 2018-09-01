package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class City {
    /*城市代码*/
    @NotEmpty(message="城市代码不能为空")
    private String cityNo;
    public String getCityNo(){
        return cityNo;
    }
    public void setCityNo(String cityNo){
        this.cityNo = cityNo;
    }

    /*城市名称*/
    @NotEmpty(message="城市名称不能为空")
    private String cityName;
    public String getCityName() {
        return cityName;
    }
    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonCity=new JSONObject(); 
		jsonCity.accumulate("cityNo", this.getCityNo());
		jsonCity.accumulate("cityName", this.getCityName());
		return jsonCity;
    }}