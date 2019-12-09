package com.houserss.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.houserss.common.Const;
import com.houserss.common.Const.Role;
import com.houserss.common.ServerResponse;
import com.houserss.dao.HouseMapper;
import com.houserss.pojo.House;
import com.houserss.pojo.User;
import com.houserss.service.IHouseService;
import com.houserss.vo.HouseVo;
import com.houserss.vo.PageInfoVo;

@Controller
@RequestMapping("/house/")
public class HouseController {

    @Autowired
    private IHouseService iHouseService;
    
    
    @Autowired
    private HouseMapper houseMapper;
    
    @RequestMapping(value="publish.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> publish(House house, @RequestParam(value = "images", required = false)MultipartFile images[], String[] deletes, HttpSession session,HttpServletRequest request){
        User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        String path = request.getSession().getServletContext().getRealPath("upload");
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录,请登录后在编辑");
        }
        return iHouseService.publish(currentUser,house, images, deletes,path);
    }
    
    @RequestMapping(value="delete.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> delete(int houseId, HttpSession session){
        User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录,请登录后在删除");
        }
        return iHouseService.delete(currentUser,houseId);
    }
    
    @RequestMapping(value="houseList.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<PageInfoVo<HouseVo>>  houseList(
            @RequestParam(value = "pageNum",defaultValue = "1")int pageNum,
            @RequestParam(value = "pageSize",defaultValue = "10") int pageSize,
            @RequestParam(value = "sellType",required = false)String sellType,
            @RequestParam(value = "zone",required = false)String zone,
            @RequestParam(value = "houseType",required = false)String houseType,
            @RequestParam(value = "minPrice",required = false)String minPrice,
            @RequestParam(value = "maxPrice",required = false)String maxPrice,
            @RequestParam(value = "orientation",required = false)String orientation,
            @RequestParam(value = "decorateType",required = false)Integer decorateType,
            @RequestParam(value = "minArea",required = false)String minArea,
            @RequestParam(value = "maxArea",required = false)String maxArea,
            @RequestParam(value = "address",required = false)String address,
            @RequestParam(value = "isSelf",defaultValue = "false")boolean isSelf,
            @RequestParam(value = "orderType",defaultValue = "0")int orderType,
            @RequestParam(value = "status",required=false)Integer status,
            @RequestParam(value = "isHide",required=false)Integer isHide,
            HttpSession session){
        int userId = 0;
        User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser != null && currentUser.getRoleType() == Role.ROLE_ADMIN) {
            return iHouseService.houseList(pageNum,pageSize,sellType,zone,houseType,minPrice,maxPrice,orientation,minArea,maxArea,address,decorateType,userId,orderType,status,isHide);
        }
        if(currentUser != null && isSelf) {
            userId = currentUser.getId();
        }
        return iHouseService.houseList(pageNum,pageSize,sellType,zone,houseType,minPrice,maxPrice,orientation,minArea,maxArea,address,decorateType,userId,orderType,status,isHide);
    }
    
    @RequestMapping(value="detailHouse.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<HouseVo> detailHouse(int houseId, HttpSession session){
        return iHouseService.detailHouse(houseId);
    }
    
    @RequestMapping(value="updateHouse.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> updateHouse(House house,HttpSession session){
        User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录");
        }
        House tempHouse = houseMapper.selectById(house.getId());
        if(tempHouse == null) {
            return ServerResponse.createByErrorMessage("未找到要修改房源信息");
        }
        return iHouseService.againPublishHouse(house);
    }
    
    @RequestMapping(value="setHideStatus.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> setHideStatus(@RequestParam(required=true)int houseId,
            @RequestParam(required=true)int isHide,HttpSession session){
        User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录");
        }
        House tempHouse = houseMapper.selectById(houseId);
        if(tempHouse == null) {
            return ServerResponse.createByErrorMessage("未找到要修改房源信息");
        }
        if(currentUser.getRoleType() == Role.ROLE_ADMIN){
            return iHouseService.setHideStatus(houseId,isHide);
        }else{
            if(tempHouse.getUserId() == currentUser.getId()){
                return iHouseService.setHideStatus(houseId,isHide);
            }
        }
        return ServerResponse.createByErrorMessage("设置房源状态异常");
    }
    // backend
    
    /**
     * 审核房源
     * @param session
     * @return
     */
    @RequestMapping(value="verified.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> verified(@RequestParam(required=true)int houseId,
            @RequestParam(required=true)int status,@RequestParam(defaultValue="",required=false)String reason,
            HttpSession session){
        User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录");
        }
        if(currentUser.getRoleType() != Role.ROLE_ADMIN) {
            return ServerResponse.createByErrorMessage("该用户无权限访问");
        }
        return iHouseService.verified(houseId,status,reason);
    }
    
}
