package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.ScenicType;

public interface ScenicTypeMapper {
	/*添加景点分类信息*/
	public void addScenicType(ScenicType scenicType) throws Exception;

	/*按照查询条件分页查询景点分类记录*/
	public ArrayList<ScenicType> queryScenicType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有景点分类记录*/
	public ArrayList<ScenicType> queryScenicTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的景点分类记录数*/
	public int queryScenicTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条景点分类记录*/
	public ScenicType getScenicType(int typeId) throws Exception;

	/*更新景点分类记录*/
	public void updateScenicType(ScenicType scenicType) throws Exception;

	/*删除景点分类记录*/
	public void deleteScenicType(int typeId) throws Exception;

}
