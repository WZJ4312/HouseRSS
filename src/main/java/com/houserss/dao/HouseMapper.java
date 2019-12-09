package com.houserss.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.houserss.pojo.House;
import com.houserss.pojo.User;

public interface HouseMapper {

    int insert(House house);
    
    int update(House house);
    
    int deleteByPrimaryKey(@Param(value="id")int id);
    
    int selectByIdAndUserId(@Param(value="id")int id,@Param(value="userId")int userId);
    
    House selectById(@Param(value="id")int id);
    
    List<House> selectHouseListByCondition(@Param(value = "start")int start,
            @Param(value = "end") int end,@Param(value = "sellType")String sellType,
            @Param(value = "zone")String zone,@Param(value = "houseType")String houseType,
            @Param(value = "minPrice")String minPrice,@Param(value = "maxPrice")String maxPrice,
            @Param(value = "orientation")String orientation,@Param(value = "minArea")String minArea,
            @Param(value = "maxArea")String maxArea,@Param(value = "address")String address,
            @Param(value = "decorateType")Integer decorateType,@Param(value = "userId")int userId,
            @Param(value = "orderType")int orderType,@Param(value = "status")Integer status,
            @Param(value = "isHide")Integer isHide);
    
    
    int selectHouseCountByCondition(@Param(value = "sellType")String sellType,
            @Param(value = "zone")String zone,@Param(value = "houseType")String houseType,
            @Param(value = "minPrice")String minPrice,@Param(value = "maxPrice")String maxPrice,
            @Param(value = "orientation")String orientation,@Param(value = "minArea")String minArea,
            @Param(value = "maxArea")String maxArea,@Param(value = "address")String address,
            @Param(value = "decorateType")Integer decorateType,@Param(value = "userId")int userId,@Param(value = "status")Integer status,
            @Param(value = "isHide")Integer isHide);
    String selectTitleById(@Param(value = "houseId")int houseId);
    
    int setHideStatus(@Param(value = "houseId")int houseId,@Param(value = "isHide")int isHide);
    
    int upadateStatus(@Param(value = "houseId")int houseId,@Param(value = "status")int status);
    
    List<House> getHouseListByUserId(@Param(value = "userId")int userId);
    
}
