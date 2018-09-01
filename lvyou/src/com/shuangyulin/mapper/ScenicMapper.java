package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.Scenic;

public interface ScenicMapper {
	/*添加景点信息*/
	public void addScenic(Scenic scenic) throws Exception;

	/*按照查询条件分页查询景点记录*/
	public ArrayList<Scenic> queryScenic(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有景点记录*/
	public ArrayList<Scenic> queryScenicList(@Param("where") String where) throws Exception;

	/*按照查询条件的景点记录数*/
	public int queryScenicCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条景点记录*/
	public Scenic getScenic(int scenicId) throws Exception;

	/*更新景点记录*/
	public void updateScenic(Scenic scenic) throws Exception;

	/*删除景点记录*/
	public void deleteScenic(int scenicId) throws Exception;

}
