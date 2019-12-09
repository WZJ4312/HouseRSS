package com.houserss.dao;

import com.houserss.pojo.User;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);
    
    User selectByPrimaryKey(Integer id);

    int changeUserStatus(@Param("id")int id,@Param("status")int status);
    
    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    int checkUsername(String username);

    int checkEmail(String email);

    User selectLogin(@Param("username") String username, @Param("password")String password);

    int updatePasswordByUsername(@Param("username")String username,@Param("passwordNew")String passwordNew);

    int checkPassword(@Param(value="password")String password,@Param("userId")Integer userId);

    int checkEmailByUserId(@Param(value="email")String email,@Param(value="userId")Integer userId);
    
    void bannedUser(@Param(value="userId")Integer userId);
    
    String selectUserNameById(Integer userId);
    
    User selectByUsername(String username);
    
    // 查看已注册列表
    List<User> getAllUser(@Param("start")Integer start,@Param("end")Integer end);
    int getCountAllUser();
}