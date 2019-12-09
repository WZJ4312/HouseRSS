package com.houserss.controller;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.houserss.common.Const;
import com.houserss.common.Const.Role;
import com.houserss.common.ServerResponse;
import com.houserss.pojo.User;
import com.houserss.service.IUserService;
import com.houserss.service.impl.UserServiceImpl;
import com.houserss.util.MD5Util;
import com.houserss.util.TimeUtils;
import com.houserss.vo.DeleteHouseVo;
import com.houserss.vo.PageInfoVo;

/**
 * Created by cw
 */
@Controller
@RequestMapping("/user/")
public class UserController {
    @Autowired
    private IUserService iUserService;

    /**
     * 用户登录
     * @param username
     * @param password
     * @param session
     * @return
     */
    @RequestMapping(value = "login.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<User> login(User user,String uvcode, HttpSession session){
        String code = (String)session.getAttribute("validationCode");
        if(StringUtils.isNotBlank(code)) {
            if(!code.equalsIgnoreCase(uvcode)) {
                return ServerResponse.createByErrorMessage("验证码不正确");
            }
        }
        ServerResponse<User> response = iUserService.login(user.getUsername(),user.getPassword());
        if(response.isSuccess()){
            session.setAttribute(Const.CURRENT_USER,response.getData());
        }
        return response;
    }

    @RequestMapping(value = "logout.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> logout(HttpSession session){
        session.removeAttribute(Const.CURRENT_USER);
        return ServerResponse.createBySuccess();
    }

    // admin 8D223A2A35C5A05467F1FF10537C7915
    
    @RequestMapping(value = "register.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> register(User user,HttpSession session){
        return iUserService.register(user);
    }

    @RequestMapping(value = "check_valid.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> checkValid(String str,String type){
        return iUserService.checkValid(str,type);
    }

    @RequestMapping(value = "reset_password.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> resetPassword(HttpSession session,String passwordOld,String passwordNew){
        User user = (User)session.getAttribute(Const.CURRENT_USER);
        if(user == null){
            return ServerResponse.createByErrorMessage("用户未登录");
        }
        return iUserService.resetPassword(passwordOld,passwordNew,user);
    }

    @RequestMapping(value = "update_information.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<User> update_information(HttpSession session,User user){
        User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录");
        }
        user.setId(currentUser.getId());
        return iUserService.updateInformation(currentUser, user);
    }
    
    @RequestMapping(value = "userList.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<PageInfoVo<User>> get_AllUser(
            @RequestParam(value = "pageNum",defaultValue = "1")int pageNum,
            @RequestParam(value = "pageSize",defaultValue = "10") int pageSize,
            HttpSession session){
        User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录");
        }
        if(currentUser.getRoleType() != Role.ROLE_ADMIN) {
            return ServerResponse.createByErrorMessage("该用户无权限访问");
        }
        return iUserService.getAllUser(pageNum,pageSize);
    }
    
    @RequestMapping(value = "sendResetPwdMail.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> sendResetPwdMail(@RequestParam(required=true)String username,
            @RequestParam(required=true)String email,@RequestParam(required=true)String code,HttpSession session){
        String validationCode = (String)session.getAttribute("validationCode");
        if(StringUtils.isNotBlank(validationCode)) {
            if(!validationCode.equalsIgnoreCase(code)) {
                return ServerResponse.createByErrorMessage("验证码不正确");
            }
        }
        return iUserService.sendResetPwdMail(username,email);
    }

    @RequestMapping(value = "resetpassword.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> resetPasswdByEmail(@RequestParam(required=true)String password,
            @RequestParam(required=true)String sign,@RequestParam(required=true)String userId,@RequestParam(required=true)String time){
        //  判断时间
        if((TimeUtils.currentSecond() -  Integer.valueOf(time)) > TimeUtils.DAY_SECONDS*2 ){
            return ServerResponse.createByErrorMessage("链接超时，请重新发邮件获取链接");
        }
        String signMD5 = MD5Util.MD5EncodeUtf8(""+userId + time + UserServiceImpl.key);
        if(!signMD5.equals(sign)){
            return ServerResponse.createByErrorMessage("sign错误。");
        }
        User user = new User();
        user.setId(Integer.valueOf(userId));
        user.setPassword(MD5Util.MD5EncodeUtf8(password));
        
        return iUserService.resetPasswd(user);
    }
    
    @RequestMapping(value = "getDeleteHouseMessge.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<PageInfoVo<DeleteHouseVo>> getDeleteHouseMessge(
            @RequestParam(value = "pageNum",defaultValue = "1")int pageNum,
            @RequestParam(value = "pageSize",defaultValue = "10") int pageSize,
    		HttpSession session){
    	User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录,请登录后在处理");
        }
        return iUserService.getDeleteHouseMessge(pageNum,pageSize,currentUser);
    }
    
    @RequestMapping(value = "deleteMessage.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> deleteMessage(int id,
    		HttpSession session){
    	User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
        if(currentUser == null){
            return ServerResponse.createByErrorMessage("用户未登录,请登录后在处理");
        }
        return iUserService.deleteMessage(id,currentUser);
    }
    
    
    // backend
    
    /**
     * @param userId
     * @param status  0正常  1封禁
     * @param session
     * @return
     */
    @RequestMapping(value = "changeUserStatus.do",method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse<String> ban(int userId,int status,HttpSession session){
    	 User currentUser = (User)session.getAttribute(Const.CURRENT_USER);
         if(currentUser == null){
             return ServerResponse.createByErrorMessage("用户未登录,请登录后在处理");
         }
         if(currentUser.getRoleType() != Role.ROLE_ADMIN){
             return ServerResponse.createByErrorMessage("该用户无权限处理");
         }
    	return  iUserService.changeUserStatus(userId,status);
    }
    
    
    
    
    
}
