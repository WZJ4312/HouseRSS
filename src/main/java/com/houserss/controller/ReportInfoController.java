package com.houserss.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.houserss.common.Const;
import com.houserss.common.Const.Role;
import com.houserss.common.ServerResponse;
import com.houserss.pojo.ReportInfo;
import com.houserss.pojo.User;
import com.houserss.service.IReportService;
import com.houserss.vo.PageInfoVo;
import com.houserss.vo.ReportInfoVo;

@Controller
@RequestMapping("/reportInfo/")
public class ReportInfoController {
    @Autowired
    private IReportService iReportService;
    
    /**
     * 投诉user或房源0用户  1房源
     * @param reportInfo
     * @param session
     * @return
     */
    @RequestMapping(value="report.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> reportHouse(ReportInfo reportInfo, HttpSession session){
        User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录,请登录后在举报");
        }
        reportInfo.setReporterId(currentUser.getId());
        return iReportService.report(reportInfo);
    }

    /**
     * 查看被成功投诉房源列表
     * @param type (1房子)
     * @param session
     * @return
     */
    @RequestMapping(value="selectHouseReportInfo.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<PageInfoVo<ReportInfoVo>> selectHouseReportInfo( 
            @RequestParam(value = "pageNum",defaultValue = "1")int pageNum,
            @RequestParam(value = "pageSize",defaultValue = "10") int pageSize,
            @RequestParam(value = "type",required = true) int type,
            HttpSession session){
        User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录,请登录后在查看");
        }
        return iReportService.selectHouseReportInfo(pageNum,pageSize,type,currentUser);
    }
    
    // backend
    
    
    /**
     * 查看投诉列表
     * @param type (0用户 1房子)
     * @param session
     * @return
     */
    @RequestMapping(value="selectReportInfo.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<PageInfoVo<ReportInfoVo>> selectReportInfo( 
            @RequestParam(value = "pageNum",defaultValue = "1")int pageNum,
            @RequestParam(value = "pageSize",defaultValue = "10") int pageSize,
            @RequestParam(value = "type",required = true) int type,
            @RequestParam(value = "status",defaultValue = "0") int status,
            HttpSession session){
        User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录,请登录后在查看");
        }
        if(currentUser.getRoleType() == Role.ROLE_ADMIN){
        	return iReportService.selectReportInfo(pageNum,pageSize,type,status,null);
        }else{
        	return iReportService.selectReportInfo(pageNum,pageSize,type,status,currentUser);
        }
    }
    
    
    /**
     * @param id
     * @param status 1(封禁、删除),2(不处理)
     * @param session
     * @return
     */
    @RequestMapping(value="dealReport.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> dealReport(int id,int status,HttpSession session){
        User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录,请登录后在处理");
        }
        if(currentUser.getRoleType() != Role.ROLE_ADMIN){
            return ServerResponse.createByErrorMessage("该用户无权限处理");
        }
        return iReportService.dealReport(id,status);
    }
    
}
