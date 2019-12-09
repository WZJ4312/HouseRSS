package com.houserss.service;

import com.houserss.common.ServerResponse;
import com.houserss.pojo.DeleteHouse;
import com.houserss.pojo.User;
import com.houserss.vo.DeleteHouseVo;
import com.houserss.vo.PageInfoVo;

/**
 * Created by cw
 */
public interface IUserService {

    ServerResponse<User> login(String username, String password);

    ServerResponse<String> register(User user);

    ServerResponse<String> checkValid(String str,String type);

    ServerResponse<String> resetPassword(String passwordOld,String passwordNew,User user);

    ServerResponse<User> updateInformation(User currentUser, User user);

    ServerResponse<User> getInformation(Integer userId);
    
    ServerResponse<PageInfoVo<User>> getAllUser(int pageNum,int pageSize);

    ServerResponse<String> changeUserStatus(int userId,int status);
    
    ServerResponse<String> sendResetPwdMail(String userName,String email);
    
    ServerResponse<String> resetPasswd(User user);
    
    ServerResponse<PageInfoVo<DeleteHouseVo>> getDeleteHouseMessge(int pageNum, int pageSize,User user);
    
    ServerResponse<String> deleteMessage(int id,User user);
    
}
