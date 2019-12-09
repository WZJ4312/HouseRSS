package com.houserss.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.houserss.common.Const;
import com.houserss.common.ServerResponse;
import com.houserss.dao.DeleteHouseMapper;
import com.houserss.dao.HouseMapper;
import com.houserss.dao.UserLogMapper;
import com.houserss.dao.UserMapper;
import com.houserss.pojo.DeleteHouse;
import com.houserss.pojo.House;
import com.houserss.pojo.User;
import com.houserss.pojo.UserLog;
import com.houserss.service.IUserService;
import com.houserss.util.MD5Util;
import com.houserss.util.SendEmail;
import com.houserss.util.TimeUtils;
import com.houserss.vo.DeleteHouseVo;
import com.houserss.vo.HouseVo;
import com.houserss.vo.PageInfoVo;

/**
 * Created by cw
 */
@Service("iUserService")
public class UserServiceImpl implements IUserService {

    /**
     * 正则表达式：验证手机号
     */
    public static final String REGEX_MOBILE = "^((17[0-9])|(14[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
 
    /**
     * 正则表达式：验证邮箱
     */
    public static final String REGEX_EMAIL = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
 
    public static final String key = "ewrdfdsafewqrwerfdsf";
    
    @Autowired
    private UserMapper userMapper;
    
    @Autowired
    private UserLogMapper userlogMapper;

    @Autowired
    private DeleteHouseMapper deleteHouseMapper;
    
    @Autowired
    private HouseMapper houeseMapper;
    
    @Override
    public ServerResponse<User> login(String username, String password) {
        if(StringUtils.isBlank(username)) {
            return ServerResponse.createByErrorMessage("用户名不能为空");
        }
        if(StringUtils.isBlank(password)) {
            return ServerResponse.createByErrorMessage("密码不能为空");
        }
        int resultCount = userMapper.checkUsername(username);
        if(resultCount == 0 ){
            return ServerResponse.createByErrorMessage("用户名不存在");
        }
        String md5Password = MD5Util.MD5EncodeUtf8(password);
        User user  = userMapper.selectLogin(username,md5Password);
        if(user == null){
            return ServerResponse.createByErrorMessage("密码错误");
        }
        user.setPassword("");
        UserLog userLog = new UserLog();
        userLog.setEventId(0);
        userLog.setUserId(user.getId());
        userLog.setLogDate(TimeUtils.getDayTime());
        userlogMapper.insert(userLog);
        return ServerResponse.createBySuccess("登录成功",user);
    }

    public ServerResponse<String> register(User user){
    	if(user == null) {
    		return ServerResponse.createByErrorMessage("参数不正确");
    	}
    	if(StringUtils.isBlank(user.getUsername())) {
    		return ServerResponse.createByErrorMessage("账号不能为空");
    	}
    	if(StringUtils.isBlank(user.getName())) {
    	    return ServerResponse.createByErrorMessage("用户名不能为空");
    	}
    	if(StringUtils.isBlank(user.getPassword())) {
    		return ServerResponse.createByErrorMessage("密码不能为空");
    	}
    	if(StringUtils.isBlank(user.getEmail())){
    	    return ServerResponse.createByErrorMessage("邮箱不能为空");
    	}
    	if(StringUtils.isBlank(user.getPhone())){
    	    return ServerResponse.createByErrorMessage("手机不能为空");
    	}
    	if(!user.getEmail().matches(REGEX_EMAIL)){
    	    return ServerResponse.createByErrorMessage("邮箱格式不正确");
    	}
    	if(!user.getPhone().matches(REGEX_MOBILE)){
    	    return ServerResponse.createByErrorMessage("手机格式不正确");
    	}
        ServerResponse validResponse = this.checkValid(user.getUsername(),Const.USERNAME);
        if(!validResponse.isSuccess()){
            return validResponse;
        }
    	validResponse = this.checkValid(user.getEmail(),Const.EMAIL);
    	if(!validResponse.isSuccess()){
    		return validResponse;
    	}
        user.setRoleType(Const.Role.ROLE_CUSTOMER);
        user.setStatus(0);
        //MD5加密
        user.setPassword(MD5Util.MD5EncodeUtf8(user.getPassword()));
        int resultCount = userMapper.insert(user);
        if(resultCount == 0){
            return ServerResponse.createByErrorMessage("注册失败");
        }
        return ServerResponse.createBySuccessMessage("注册成功");
    }

    public ServerResponse<String> checkValid(String str,String type){
        if(org.apache.commons.lang3.StringUtils.isNotBlank(type)){
            //开始校验
            if(Const.USERNAME.equals(type)){
                int resultCount=0;
                try{
                    resultCount = userMapper.checkUsername(str);
                }catch (Exception e){
                    e.printStackTrace();
                }
                if(resultCount > 0 ){
                    return ServerResponse.createByErrorMessage("用户名已存在");
                }
            }
            if(Const.EMAIL.equals(type)){
                int resultCount = userMapper.checkEmail(str);
                if(resultCount > 0 ){
                    return ServerResponse.createByErrorMessage("email已存在");
                }
            }
        }else{
            return ServerResponse.createByErrorMessage("参数错误");
        }
        return ServerResponse.createBySuccessMessage("校验成功");
    }

    public ServerResponse<String> resetPassword(String passwordOld,String passwordNew,User user){
        int resultCount = userMapper.checkPassword(MD5Util.MD5EncodeUtf8(passwordOld),user.getId());
        if(resultCount == 0){
            return ServerResponse.createByErrorMessage("旧密码错误");
        }
        user.setPassword(MD5Util.MD5EncodeUtf8(passwordNew));
        int updateCount = userMapper.updateByPrimaryKeySelective(user);
        if(updateCount > 0){
            return ServerResponse.createBySuccessMessage("密码更新成功");
        }
        return ServerResponse.createByErrorMessage("密码更新失败");
    }

    public ServerResponse<User> updateInformation(User currentUser, User updateUser){
        //username是不能被更新的
        //email也要进行一个校验,校验新的email是不是已经存在,并且存在的email如果相同的话,不能是我们当前的这个用户的.
        int resultCount = userMapper.checkEmailByUserId(updateUser.getEmail(),updateUser.getId());
        if(resultCount > 0){
            return ServerResponse.createByErrorMessage("email已存在,请更换email再尝试更新");
        }
        if (updateUser.getName() != null) {
        	if (StringUtils.isBlank(updateUser.getName())) {
                return ServerResponse.createByErrorMessage("姓名不能为空");
			}
        	currentUser.setName(updateUser.getName());
		}
        if (updateUser.getEmail() != null) {
            if(!updateUser.getEmail().matches(REGEX_EMAIL)){
                return ServerResponse.createByErrorMessage("邮箱格式不正确");
            }
        	currentUser.setEmail(updateUser.getEmail());
		}
        if (updateUser.getPhone() != null) {
            if(!updateUser.getPhone().matches(REGEX_MOBILE)){
                return ServerResponse.createByErrorMessage("手机格式不正确");
            }
        	currentUser.setPhone(updateUser.getPhone());
		}
        int updateCount = userMapper.updateByPrimaryKeySelective(updateUser);
        if(updateCount > 0){
            return ServerResponse.createBySuccess("更新个人信息成功",currentUser);
        }
        return ServerResponse.createByErrorMessage("更新个人信息失败");
    }

    public ServerResponse<User> getInformation(Integer userId){
        User user = userMapper.selectByPrimaryKey(userId);
        if(user == null){
            return ServerResponse.createByErrorMessage("找不到当前用户");
        }
        user.setPassword(org.apache.commons.lang3.StringUtils.EMPTY);
        return ServerResponse.createBySuccess(user);

    }

    //backend

    /**
     * 校验是否是管理员
     * @param user
     * @return
     */
    public ServerResponse checkAdminRole(User user){
        if(user != null && user.getRoleType()== Const.Role.ROLE_ADMIN){
            return ServerResponse.createBySuccess();
        }
        return ServerResponse.createByError();
    }

    @Override
    public ServerResponse<PageInfoVo<User>> getAllUser(int pageNum,int pageSize) {
        PageInfoVo<User> pages = new PageInfoVo<User>();
        int start = (pageNum-1)*pageSize;
        int end = pageNum*pageSize-1;
        List<User> allUser = userMapper.getAllUser(start,end);
        if(allUser == null) {
            pages.setSumPage(1);
        }else {
            int count = userMapper.getCountAllUser();
            pages.setSumPage((count+pageSize-1)/pageSize);
        }
        pages.setCurPage(pageNum);
        pages.setPageSize(pageSize);
        pages.setData(allUser);
        return ServerResponse.createBySuccess(pages);
    }

	@Override
	public ServerResponse<String> changeUserStatus(int userId, int status) {
		// 检查userId
		User user = userMapper.selectByPrimaryKey(userId);
		if(status != 0 && status != 1){
			return ServerResponse.createByErrorMessage("传入status 不正确");
		}
		if(user == null){
			return ServerResponse.createByErrorMessage("传入userId 不正确");
		}
		if(user.getStatus() == status){
			return ServerResponse.createByErrorMessage("用户状态相同，无需修改");
		}
		userMapper.changeUserStatus(userId,status);
		return ServerResponse.createBySuccessMessage("状态修改成功。");
	}

    @Override
    public ServerResponse<String> sendResetPwdMail(String userName, String email) {
        int resultCount = userMapper.checkUsername(userName);
        if(resultCount == 0 ){
            return ServerResponse.createByErrorMessage("用户名不存在");
        }
        User user = userMapper.selectByUsername(userName);
        int userId = user.getId();
        int curTime =TimeUtils.currentSecond();
        StringBuilder content = new StringBuilder();
        String sign = MD5Util.MD5EncodeUtf8(""+userId + curTime + key);
        
        content.append("http://localhost:8080/HouseRSS/web/reset_passwd.jsp?");
        content.append("userId="+userId);
        content.append("&");
        content.append("sign="+sign);
        content.append("&");
        content.append("time="+curTime);
        
        String title = "房屋租赁平台找回密码链接。";
        boolean flag = SendEmail.sendEmail(content.toString(), user.getEmail(),title);
        if(flag){
            return ServerResponse.createBySuccessMessage("发送成功");
        }
        return ServerResponse.createByErrorMessage("发送失败");
    }

    @Override
    public ServerResponse<String> resetPasswd(User user) {
        int updateCount = userMapper.updateByPrimaryKeySelective(user);
        if(updateCount > 0){
            return ServerResponse.createBySuccessMessage("重设密码成功");
        }
        return ServerResponse.createByErrorMessage("重设密码失败");
    }

	@Override
	public ServerResponse<PageInfoVo<DeleteHouseVo>> getDeleteHouseMessge(int pageNum, int pageSize,User user) {
		PageInfoVo<DeleteHouseVo> housePageInfoVo = new PageInfoVo<DeleteHouseVo>();
		if(user == null){
			return ServerResponse.createByErrorMessage("获取失败");
		}
		List<DeleteHouse> deleteHouses = deleteHouseMapper.getByUserId(user.getId());
		deleteHouses.sort((t1,t2)->{
			return t1.getId() - t2.getId();
		});
		if (deleteHouses.size() == 0) {
            housePageInfoVo.setSumPage(1);
        } else {
        	housePageInfoVo.setCurPage(pageNum);
        	housePageInfoVo.setPageSize(pageSize);
        	housePageInfoVo.setData(deleteHouseToVo(deleteHouses));
        	housePageInfoVo.setSumPage((deleteHouses.size() + pageSize - 1) / pageSize);
        }
		return ServerResponse.createBySuccess(housePageInfoVo);
	}

	private List<DeleteHouseVo> deleteHouseToVo(List<DeleteHouse> deleteHouses){
		List<DeleteHouseVo> deleteHouseVos = new ArrayList<>();
		for (int i = 0; i < deleteHouses.size(); i++) {
			DeleteHouseVo deleteHouseVo = new DeleteHouseVo();
			DeleteHouse deleteHouse = deleteHouses.get(i);
			deleteHouseVo.setId(deleteHouse.getId());
			deleteHouseVo.setUserId(deleteHouse.getUserId());
			deleteHouseVo.setHouseId(deleteHouse.getHouseId());
			deleteHouseVo.setDeleteDate(deleteHouse.getDeleteDate());
			House house =houeseMapper.selectById(deleteHouseVo.getHouseId());
			if(house == null){
				continue;
			}
			deleteHouseVo.setHouseTitle(house.getTitle());
			deleteHouseVos.add(deleteHouseVo);
		}
		return deleteHouseVos;
	}

	@Override
	public ServerResponse<String> deleteMessage(int id, User user) {
		
		DeleteHouse deleteHouse = deleteHouseMapper.get(id);
		if(deleteHouse == null){
			return ServerResponse.createByErrorMessage("没有可删除的消息");
		}
		if(user.getId() != deleteHouse.getUserId()){
			return ServerResponse.createByErrorMessage("没有可删除的消息");
		}
		deleteHouseMapper.deleterById(id);
		
		return ServerResponse.createBySuccessMessage("删除成功");
	}
}
