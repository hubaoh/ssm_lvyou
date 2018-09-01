package com.shuangyulin.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.shuangyulin.po.Scenic;
import com.shuangyulin.po.UserInfo;
import com.shuangyulin.po.OrderInfo;

import com.shuangyulin.mapper.OrderInfoMapper;
@Service
public class OrderInfoService {

	@Resource OrderInfoMapper orderInfoMapper;
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

    /*添加订单记录*/
    public void addOrderInfo(OrderInfo orderInfo) throws Exception {
    	orderInfoMapper.addOrderInfo(orderInfo);
    }

    /*按照查询条件分页查询订单记录*/
    public ArrayList<OrderInfo> queryOrderInfo(Scenic scenicObj,String orderDate,UserInfo userObj,String shState,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != scenicObj && scenicObj.getScenicId()!= null && scenicObj.getScenicId()!= 0)  where += " and t_orderInfo.scenicObj=" + scenicObj.getScenicId();
    	if(!orderDate.equals("")) where = where + " and t_orderInfo.orderDate like '%" + orderDate + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_orderInfo.userObj='" + userObj.getUser_name() + "'";
    	if(!shState.equals("")) where = where + " and t_orderInfo.shState like '%" + shState + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return orderInfoMapper.queryOrderInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<OrderInfo> queryOrderInfo(Scenic scenicObj,String orderDate,UserInfo userObj,String shState) throws Exception  { 
     	String where = "where 1=1";
    	if(null != scenicObj && scenicObj.getScenicId()!= null && scenicObj.getScenicId()!= 0)  where += " and t_orderInfo.scenicObj=" + scenicObj.getScenicId();
    	if(!orderDate.equals("")) where = where + " and t_orderInfo.orderDate like '%" + orderDate + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_orderInfo.userObj='" + userObj.getUser_name() + "'";
    	if(!shState.equals("")) where = where + " and t_orderInfo.shState like '%" + shState + "%'";
    	return orderInfoMapper.queryOrderInfoList(where);
    }

    /*查询所有订单记录*/
    public ArrayList<OrderInfo> queryAllOrderInfo()  throws Exception {
        return orderInfoMapper.queryOrderInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Scenic scenicObj,String orderDate,UserInfo userObj,String shState) throws Exception {
     	String where = "where 1=1";
    	if(null != scenicObj && scenicObj.getScenicId()!= null && scenicObj.getScenicId()!= 0)  where += " and t_orderInfo.scenicObj=" + scenicObj.getScenicId();
    	if(!orderDate.equals("")) where = where + " and t_orderInfo.orderDate like '%" + orderDate + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_orderInfo.userObj='" + userObj.getUser_name() + "'";
    	if(!shState.equals("")) where = where + " and t_orderInfo.shState like '%" + shState + "%'";
        recordNumber = orderInfoMapper.queryOrderInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取订单记录*/
    public OrderInfo getOrderInfo(int orderId) throws Exception  {
        OrderInfo orderInfo = orderInfoMapper.getOrderInfo(orderId);
        return orderInfo;
    }

    /*更新订单记录*/
    public void updateOrderInfo(OrderInfo orderInfo) throws Exception {
        orderInfoMapper.updateOrderInfo(orderInfo);
    }

    /*删除一条订单记录*/
    public void deleteOrderInfo (int orderId) throws Exception {
        orderInfoMapper.deleteOrderInfo(orderId);
    }

    /*删除多条订单信息*/
    public int deleteOrderInfos (String orderIds) throws Exception {
    	String _orderIds[] = orderIds.split(",");
    	for(String _orderId: _orderIds) {
    		orderInfoMapper.deleteOrderInfo(Integer.parseInt(_orderId));
    	}
    	return _orderIds.length;
    }
}
