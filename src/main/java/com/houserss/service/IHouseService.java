package com.houserss.service;

import org.springframework.web.multipart.MultipartFile;

import com.houserss.common.ServerResponse;
import com.houserss.pojo.DeleteHouse;
import com.houserss.pojo.House;
import com.houserss.pojo.User;
import com.houserss.vo.HouseVo;
import com.houserss.vo.PageInfoVo;

public interface IHouseService {
    ServerResponse<String> publish(User user,House house,MultipartFile[] images,String[] deletes,String path);
    
    ServerResponse<PageInfoVo<HouseVo>> houseList(int pageNum,int pageSize,String sellType,String zone,String houseType,String minPrice,String maxPrice,
            String orientation,String minArea,String maxArea,String address,Integer decorateType,int userId,int orderType,Integer status,Integer isHide);
    
    ServerResponse<String> delete(User user,int houseId);
    
    ServerResponse<HouseVo> detailHouse(int houseId);
    
    ServerResponse<String> verified(int houseId,int status,String reason);
    
    ServerResponse<String> againPublishHouse(House houes);
    
    ServerResponse<String> setHideStatus(int houesId,int isHide);
    
}
