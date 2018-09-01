package com.shuangyulin.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.shuangyulin.utils.ExportExcelUtil;
import com.shuangyulin.utils.UserException;
import com.shuangyulin.service.CityService;
import com.shuangyulin.po.City;

//City管理控制层
@Controller
@RequestMapping("/City")
public class CityController extends BaseController {

    /*业务层对象*/
    @Resource CityService cityService;

	@InitBinder("city")
	public void initBinderCity(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("city.");
	}
	/*跳转到添加City视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new City());
		return "City_add";
	}

	/*客户端ajax方式提交添加城市信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated City city, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(cityService.getCity(city.getCityNo()) != null) {
			message = "城市代码已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
        cityService.addCity(city);
        message = "城市添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询城市信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)cityService.setRows(rows);
		List<City> cityList = cityService.queryCity(page);
	    /*计算总的页数和总的记录数*/
	    cityService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = cityService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = cityService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(City city:cityList) {
			JSONObject jsonCity = city.getJsonObject();
			jsonArray.put(jsonCity);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询城市信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<City> cityList = cityService.queryAllCity();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(City city:cityList) {
			JSONObject jsonCity = new JSONObject();
			jsonCity.accumulate("cityNo", city.getCityNo());
			jsonCity.accumulate("cityName", city.getCityName());
			jsonArray.put(jsonCity);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询城市信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<City> cityList = cityService.queryCity(currentPage);
	    /*计算总的页数和总的记录数*/
	    cityService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = cityService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = cityService.getRecordNumber();
	    request.setAttribute("cityList",  cityList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "City/city_frontquery_result"; 
	}

     /*前台查询City信息*/
	@RequestMapping(value="/{cityNo}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String cityNo,Model model,HttpServletRequest request) throws Exception {
		/*根据主键cityNo获取City对象*/
        City city = cityService.getCity(cityNo);

        request.setAttribute("city",  city);
        return "City/city_frontshow";
	}

	/*ajax方式显示城市修改jsp视图页*/
	@RequestMapping(value="/{cityNo}/update",method=RequestMethod.GET)
	public void update(@PathVariable String cityNo,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键cityNo获取City对象*/
        City city = cityService.getCity(cityNo);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonCity = city.getJsonObject();
		out.println(jsonCity.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新城市信息*/
	@RequestMapping(value = "/{cityNo}/update", method = RequestMethod.POST)
	public void update(@Validated City city, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			cityService.updateCity(city);
			message = "城市更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "城市更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除城市信息*/
	@RequestMapping(value="/{cityNo}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String cityNo,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  cityService.deleteCity(cityNo);
	            request.setAttribute("message", "城市删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "城市删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条城市记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String cityNos,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = cityService.deleteCitys(cityNos);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出城市信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<City> cityList = cityService.queryCity();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "City信息记录"; 
        String[] headers = { "城市代码","城市名称"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<cityList.size();i++) {
        	City city = cityList.get(i); 
        	dataset.add(new String[]{city.getCityNo(),city.getCityName()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"City.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
