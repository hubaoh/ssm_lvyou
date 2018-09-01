package com.shuangyulin.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.shuangyulin.po.ScenicType;

import com.shuangyulin.mapper.ScenicTypeMapper;
@Service
public class ScenicTypeService {

	@Resource ScenicTypeMapper scenicTypeMapper;
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

    /*添加景点分类记录*/
    public void addScenicType(ScenicType scenicType) throws Exception {
    	scenicTypeMapper.addScenicType(scenicType);
    }

    /*按照查询条件分页查询景点分类记录*/
    public ArrayList<ScenicType> queryScenicType(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return scenicTypeMapper.queryScenicType(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<ScenicType> queryScenicType() throws Exception  { 
     	String where = "where 1=1";
    	return scenicTypeMapper.queryScenicTypeList(where);
    }

    /*查询所有景点分类记录*/
    public ArrayList<ScenicType> queryAllScenicType()  throws Exception {
        return scenicTypeMapper.queryScenicTypeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = scenicTypeMapper.queryScenicTypeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取景点分类记录*/
    public ScenicType getScenicType(int typeId) throws Exception  {
        ScenicType scenicType = scenicTypeMapper.getScenicType(typeId);
        return scenicType;
    }

    /*更新景点分类记录*/
    public void updateScenicType(ScenicType scenicType) throws Exception {
        scenicTypeMapper.updateScenicType(scenicType);
    }

    /*删除一条景点分类记录*/
    public void deleteScenicType (int typeId) throws Exception {
        scenicTypeMapper.deleteScenicType(typeId);
    }

    /*删除多条景点分类信息*/
    public int deleteScenicTypes (String typeIds) throws Exception {
    	String _typeIds[] = typeIds.split(",");
    	for(String _typeId: _typeIds) {
    		scenicTypeMapper.deleteScenicType(Integer.parseInt(_typeId));
    	}
    	return _typeIds.length;
    }
}
