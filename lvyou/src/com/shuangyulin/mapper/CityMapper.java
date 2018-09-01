package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.City;

public interface CityMapper {
	/*添加城市信息*/
	public void addCity(City city) throws Exception;

	/*按照查询条件分页查询城市记录*/
	public ArrayList<City> queryCity(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有城市记录*/
	public ArrayList<City> queryCityList(@Param("where") String where) throws Exception;

	/*按照查询条件的城市记录数*/
	public int queryCityCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条城市记录*/
	public City getCity(String cityNo) throws Exception;

	/*更新城市记录*/
	public void updateCity(City city) throws Exception;

	/*删除城市记录*/
	public void deleteCity(String cityNo) throws Exception;

}
