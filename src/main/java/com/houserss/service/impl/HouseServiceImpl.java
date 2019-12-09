package com.houserss.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.houserss.common.Const.Role;
import com.houserss.common.ServerResponse;
import com.houserss.dao.DeleteHouseMapper;
import com.houserss.dao.HouseLogMapper;
import com.houserss.dao.HouseMapper;
import com.houserss.dao.UserMapper;
import com.houserss.pojo.DeleteHouse;
import com.houserss.pojo.House;
import com.houserss.pojo.HouseLog;
import com.houserss.pojo.User;
import com.houserss.service.IHouseService;
import com.houserss.util.TimeUtils;
import com.houserss.vo.HouseVo;
import com.houserss.vo.PageInfoVo;

/**
 * Created by cw
 */
@Service("iHouseService")
public class HouseServiceImpl implements IHouseService {

    @Autowired
    private HouseMapper houseMapper;

    @Autowired
    private UserMapper userMapper;
    
    @Autowired
    private HouseLogMapper houselogMapper;

    @Autowired
    private FileServiceImpl iFileService;
    
    @Autowired
    private DeleteHouseMapper deleteHouseMapper;

    @Override
    public ServerResponse<String> publish(User user, House house, MultipartFile[] images, String[] deletes,
            String path) {
        if (house == null) {
            return ServerResponse.createByErrorMessage("房源参数有误");
        }
        if (StringUtils.isBlank(house.getZone())) {
            return ServerResponse.createByErrorMessage("区域不能为空");
        }
        if (house.getSellType() == null || (house.getSellType() != 0 && house.getSellType() != 1)) {
            return ServerResponse.createByErrorMessage("租售类型参数有误");
        }
        if (house.getHouseType() == null || house.getHouseType() < 0 || house.getHouseType() > 5) {
            return ServerResponse.createByErrorMessage("户型参数有误");
        }
        List<String> uploads = new ArrayList<String>();
        StringBuilder sb = new StringBuilder();
        if (house.getId() == null) {
            if (images == null || images.length < 1) {
                return ServerResponse.createByErrorMessage("图片不能为空");
            }
            // 新增
            for (int i = 0; i < images.length; i++) {
                String headFileName = Integer.toString(user.getId());
                String image = iFileService.upload(images[i], headFileName, path);
                if (image != null) {
                    uploads.add(image);
                    sb.append(image).append(",");
                }
            }
            if (sb.length() > 0) {
                house.setImageInfos(sb.substring(0, sb.length() - 1));
            } else {
                return ServerResponse.createByErrorMessage("发布任务失败");
            }
            house.setUserId(user.getId());
            house.setPublishDate(TimeUtils.getDayTime());
            house.setStatus(0);
            house.setIsHide(0);
            int count = houseMapper.insert(house);
            if (count > 0) {
                return ServerResponse.createBySuccessMessage("发布任务成功");
            } else {
                // 删除上传文件
                iFileService.delete(uploads);
                return ServerResponse.createByErrorMessage("发布任务失败");
            }
        } else {
            // 修改
            if (user.getId().equals(house.getUserId())) {
                return ServerResponse.createByErrorMessage("不能修改非自己房源");
            }
            List<String> curImagesList = new ArrayList<String>();
            
            House temp = houseMapper.selectById(house.getId());
            
            if (temp != null && temp.getImageInfos() != null) {
                String[] curImages = temp.getImageInfos().split(",");
                for (int i = 0; i < curImages.length; i++) {
                    curImagesList.add(curImages[i]);
                }
            }
            if (deletes != null && deletes.length > 0) {
                iFileService.delete(Arrays.asList(deletes));
                for (int i = 0; i < deletes.length; i++) {
                    if (curImagesList.contains(deletes[i])) {
                        curImagesList.remove(deletes[i]);
                    }
                }
            }
            if(images != null) {
                for (int i = 0; i < images.length; i++) {
                    String headFileName = Integer.toString(user.getId());
                    String image = iFileService.upload(images[i], headFileName, path);
                    if (image != null) {
                        uploads.add(image);
                        curImagesList.add(image);
                    }
                }
            }
            if(curImagesList.size() == 0) {
                return ServerResponse.createByErrorMessage("图片不能为空");
            }
            for (int i = 0; i < curImagesList.size(); i++) {
                sb.append(curImagesList.get(i)).append(",");
            }
            house.setImageInfos(sb.substring(0, sb.length() - 1));
            house.setStatus(0);
            house.setReason("");
            int count = houseMapper.update(house);
            if (count > 0) {
                return ServerResponse.createBySuccessMessage("发布任务成功");
            } else {
                // 删除上传文件
                iFileService.delete(uploads);
                return ServerResponse.createByErrorMessage("发布任务失败");
            }
        }
    }

    @Override
    public ServerResponse<String> delete(User user, int houseId) {
        House house = houseMapper.selectById(houseId);
        if (house == null) {
            return ServerResponse.createByErrorMessage("房源信息不存在");
        }
        if (user.getRoleType() == Role.ROLE_ADMIN) {
        	// 伪删除 将status 改为3
        	int rescount = houseMapper.upadateStatus(houseId,3);
        	if(rescount > 0){
        		// 通知用户
        		DeleteHouse deleteHouse = new DeleteHouse();
        		deleteHouse.setUserId(house.getUserId());
        		deleteHouse.setHouseId(houseId);
        		deleteHouse.setDeleteDate(TimeUtils.getDayTime());
        		deleteHouseMapper.insert(deleteHouse);
        	}
            return ServerResponse.createBySuccessMessage("删除房源成功");
        } else {
            if (house.getUserId() != user.getId()) {
                return ServerResponse.createBySuccessMessage("房源不属于该用户");
            }
            houseMapper.deleteByPrimaryKey(houseId);
            return ServerResponse.createBySuccessMessage("删除房源成功");
        }
    }

    /*
     * orderType 0默认排序 1面积降序 2价格升序 3时间降序
     */
    @Override
    public ServerResponse<PageInfoVo<HouseVo>> houseList(int pageNum, int pageSize, String sellType, String zone,
            String houseType, String minPrice, String maxPrice, String orientation, String minArea, String maxArea,
            String address, Integer decorateType, int userId, int orderType, Integer status, Integer isHide) {
        PageInfoVo<HouseVo> housePageInfoVo = new PageInfoVo<HouseVo>();
        int start = (pageNum - 1) * pageSize;
        int end = pageNum * pageSize - 1;

        List<House> listHouse = houseMapper.selectHouseListByCondition(start, end, sellType, zone, houseType, minPrice,
                maxPrice, orientation, minArea, maxArea, address, decorateType, userId, orderType, status, isHide);
        if (listHouse == null) {
            housePageInfoVo.setSumPage(1);
        } else {
            int count = houseMapper.selectHouseCountByCondition(sellType, zone, houseType, minPrice, maxPrice,
                    orientation, minArea, maxArea, address, decorateType, userId, status, isHide);
            housePageInfoVo.setSumPage((count + pageSize - 1) / pageSize);
        }
        List<HouseVo> houseVos = new ArrayList<HouseVo>();
        for (int i = 0; i < listHouse.size(); i++) {
            houseVos.add(HouseToHouseVo(listHouse.get(i)));
        }
        housePageInfoVo.setCurPage(pageNum);
        housePageInfoVo.setData(houseVos);
        housePageInfoVo.setPageSize(pageSize);
        return ServerResponse.createBySuccess(housePageInfoVo);
    }

    private HouseVo HouseToHouseVo(House house) {
        HouseVo houseVo = new HouseVo();
        User user = userMapper.selectByPrimaryKey(house.getUserId());
        houseVo.setId(house.getId());
        houseVo.setSellType(house.getSellType());
        houseVo.setZone(house.getZone());
        houseVo.setHouseType(house.getHouseType());
        houseVo.setPrice(house.getPrice());
        houseVo.setOrientation(house.getOrientation());
        houseVo.setDecorateType(house.getDecorateType());
        houseVo.setFloor(house.getFloor());
        houseVo.setTitle(house.getTitle());
        houseVo.setDecoration(house.getDecoration());
        houseVo.setArea(house.getArea());
        houseVo.setAddress(house.getAddress());
        houseVo.setImageInfos(house.getImageInfos());
        houseVo.setUserId(house.getUserId());
        houseVo.setStatus(house.getStatus());
        houseVo.setIsHide(house.getIsHide());
        houseVo.setReason(house.getReason());
        houseVo.setPublishDate(house.getPublishDate());
        houseVo.setPublisherName(user.getName());
        houseVo.setPublishPhone(user.getPhone());
        return houseVo;
    }

    @Override
    public ServerResponse<HouseVo> detailHouse(int houseId) {
        House house = houseMapper.selectById(houseId);
        if (house == null) {
            return ServerResponse.createByErrorMessage("未找到房源信息");
        }
        return ServerResponse.createBySuccess(HouseToHouseVo(house));
    }

    @Override
    public ServerResponse<String> verified(int houseId, int status,String reason) {
        House house = houseMapper.selectById(houseId);
        if (house == null) {
            return ServerResponse.createByErrorMessage("未找到房源信息");
        }
        if(status != 1 && status != 2){
            return ServerResponse.createByErrorMessage("审核状态有误");
        }
        house.setStatus(status);
        if(status == 2){
            house.setReason(reason);
        }
        int resCount = houseMapper.update(house);
        if (resCount > 0) {
            HouseLog houseLog = new HouseLog();
            houseLog.setEventId(0);
            houseLog.setHouseId(houseId);
            houseLog.setLogDate(TimeUtils.getDayTime());
            houselogMapper.insert(houseLog);
            return ServerResponse.createBySuccessMessage("处理成功");
        }
        return ServerResponse.createByErrorMessage("处理失败");
    }

    @Override
    public ServerResponse<String> againPublishHouse(House house) {
        house.setStatus(0);
        house.setReason("");
        int resCount = houseMapper.update(house);
        if (resCount > 0) {
            return ServerResponse.createBySuccessMessage("更新成功");
        }
        return ServerResponse.createByErrorMessage("更新失败");
    }

    @Override
    public ServerResponse<String> setHideStatus(int houesId, int isHide) {
        if(isHide != 0 && isHide != 1){
            ServerResponse.createByErrorMessage("传入的status错误");
        }
        int resCount = houseMapper.setHideStatus(houesId,isHide);
        if (resCount > 0) {
            return ServerResponse.createBySuccessMessage("更新成功");
        }
        return ServerResponse.createByErrorMessage("更新失败");
    }


}
