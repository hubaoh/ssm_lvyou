package com.shuangyulin.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.shuangyulin.po.City;

import com.shuangyulin.mapper.CityMapper;
@Service
public class CityService {

	@Resource CityMapper cityMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加城市记录*/
    public void addCity(City city) throws Exception {
    	cityMapper.addCity(city);
    }

    /*按照查询条件分页查询城市记录*/
    public ArrayList<City> queryCity(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return cityMapper.queryCity(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<City> queryCity() throws Exception  { 
     	String where = "where 1=1";
    	return cityMapper.queryCityList(where);
    }

    /*查询所有城市记录*/
    public ArrayList<City> queryAllCity()  throws Exception {
        return cityMapper.queryCityList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = cityMapper.queryCityCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取城市记录*/
    public City getCity(String cityNo) throws Exception  {
        City city = cityMapper.getCity(cityNo);
        return city;
    }

    /*更新城市记录*/
    public void updateCity(City city) throws Exception {
        cityMapper.updateCity(city);
    }

    /*删除一条城市记录*/
    public void deleteCity (String cityNo) throws Exception {
        cityMapper.deleteCity(cityNo);
    }

    /*删除多条城市信息*/
    public int deleteCitys (String cityNos) throws Exception {
    	String _cityNos[] = cityNos.split(",");
    	for(String _cityNo: _cityNos) {
    		cityMapper.deleteCity(_cityNo);
    	}
    	return _cityNos.length;
    }
}
