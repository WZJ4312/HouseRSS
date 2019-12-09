package com.houserss.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.houserss.common.ServerResponse;
import com.houserss.dao.DeleteHouseMapper;
import com.houserss.dao.HouseMapper;
import com.houserss.dao.ReportInfoMapper;
import com.houserss.dao.UserMapper;
import com.houserss.pojo.DeleteHouse;
import com.houserss.pojo.House;
import com.houserss.pojo.ReportInfo;
import com.houserss.pojo.User;
import com.houserss.service.IReportService;
import com.houserss.util.TimeUtils;
import com.houserss.vo.PageInfoVo;
import com.houserss.vo.ReportInfoVo;

@Service("iReportService")
public class ReportService implements IReportService{

    @Autowired
    private ReportInfoMapper reportInfoMapper;
    
    @Autowired
    private UserMapper userMapper;
    
    @Autowired
    private HouseMapper houseMapper;
    
    @Autowired
    private DeleteHouseMapper deleteHouseMapper;
    
    @Override
    public ServerResponse<String> report(ReportInfo reportInfo) {
        if(reportInfo.getReporterId() == null) {
            return ServerResponse.createByErrorMessage("被投诉对象参数不正确");
        }
        if(reportInfo.getType() == null) {
            return ServerResponse.createByErrorMessage("投诉类型不能为空");
        }
        if(StringUtils.isBlank(reportInfo.getDescription())) {
            return ServerResponse.createByErrorMessage("描述参数不能为空");
        }
        reportInfo.setId(null);
        reportInfo.setStatus(0);
        reportInfo.setReportDate(TimeUtils.getDayTime());
        int resCount = reportInfoMapper.insert(reportInfo);
        if(resCount >0) {
            return ServerResponse.createBySuccessMessage("投诉成功");
        }else {
            return ServerResponse.createByErrorMessage("投诉失败");
        }
    }
    
    @Override
    public ServerResponse<PageInfoVo<ReportInfoVo>> selectReportInfo(int pageNum,int pageSize,int type,int status,User user) {
        PageInfoVo<ReportInfoVo> housePageInfoVo = new PageInfoVo<ReportInfoVo>();
        int start = (pageNum-1)*pageSize;
        int end = pageNum*pageSize-1;
        List<ReportInfo> reportInfos = null;
        int userId = user == null? 0:user.getId();
        int isSuccess = user == null? 0:1;
        reportInfos = reportInfoMapper.selectBytype(start,end,type,status,userId,isSuccess);
        
        if(reportInfos == null) {
            housePageInfoVo.setSumPage(1);
        }else {
            int sumPage = reportInfoMapper.selectCountBytype(type,status,userId,isSuccess);
            housePageInfoVo.setSumPage((sumPage+pageSize-1)/pageSize);
        }
        List<ReportInfoVo> infoVos = new ArrayList<ReportInfoVo>();
        for (int i = 0; i < reportInfos.size(); i++) {
            infoVos.add(reportInfoToReportInfoVo(reportInfos.get(i)));
        }
        housePageInfoVo.setCurPage(pageNum);
        housePageInfoVo.setData(infoVos);
        housePageInfoVo.setPageSize(pageSize);
        
        return ServerResponse.createBySuccess(housePageInfoVo);
    }

    private ReportInfoVo reportInfoToReportInfoVo(ReportInfo info){
        ReportInfoVo reportInfoVo = new ReportInfoVo();
        reportInfoVo.setId(info.getId());
        reportInfoVo.setReporterId(info.getReporterId());
        reportInfoVo.setReportDate(info.getReportDate());
        reportInfoVo.setDescription(info.getDescription());
        reportInfoVo.setReportederId(info.getReportederId());
        reportInfoVo.setReporterUsername(userMapper.selectUserNameById(info.getReporterId()));
        if(info.getType() == 0) {
            // 用户
            reportInfoVo.setUsername(userMapper.selectUserNameById(info.getReportederId()));
        }else if(info.getType() ==1) {
            // 房子
            reportInfoVo.setTitle(houseMapper.selectTitleById(info.getReportederId()));
        }
        return reportInfoVo;
    }
    
    /* 
     * type 0 忽略  1处理（删数据 或者 封禁）
     * 
     */
    public ServerResponse<String> dealReport(int id, int status) {
        ReportInfo reportInfo = reportInfoMapper.selectById(id);
        if(reportInfo == null){
            return ServerResponse.createByErrorMessage("数据不存在");
        }
        if(status != 0 && status != 1) {
            return ServerResponse.createByErrorMessage("传入type 出错");
        }
        reportInfoMapper.updateStatus(id,1,status);
        if(status == 0){
            return ServerResponse.createBySuccessMessage("处理成功！");
        }
        if(status ==1 ) {
            // 删除相应的投诉信息
            if(reportInfo.getType() == 0) {
                // 封禁用户
                userMapper.bannedUser(reportInfo.getReporterId());
                return ServerResponse.createBySuccessMessage("处理成功！该用户已被封禁");
            }
            if(reportInfo.getType() == 1) {
                // 伪删除 将status 改为3
            	int rescount = houseMapper.upadateStatus(reportInfo.getReportederId(),3);
            	if(rescount > 0){
            		// 通知用户
            		House house = houseMapper.selectById(reportInfo.getReportederId());
            		DeleteHouse deleteHouse = new DeleteHouse();
            		deleteHouse.setUserId(house.getUserId());
            		deleteHouse.setHouseId(reportInfo.getReportederId());
            		deleteHouse.setDeleteDate(TimeUtils.getDayTime());
            		deleteHouseMapper.insert(deleteHouse);
            	}
                return ServerResponse.createBySuccessMessage("处理成功！该房源已被删除");
            }
        }
        return ServerResponse.createByErrorMessage("处理失败");
    }

	@Override
	public ServerResponse<PageInfoVo<ReportInfoVo>> selectHouseReportInfo(int pageNum, int pageSize,int type, User user) {
		PageInfoVo<ReportInfoVo> housePageInfoVo = new PageInfoVo<ReportInfoVo>();
        int start = (pageNum-1)*pageSize;
        int end = pageNum*pageSize-1;
        List<ReportInfo> reportInfos = new ArrayList<>();
        if(user == null){
        	return ServerResponse.createByError();
        }
        List<ReportInfo> reportInfoList = reportInfoMapper.getSucessReport(1,1);
        
        Iterator<ReportInfo> iterator = reportInfoList.iterator();
        while(iterator.hasNext()){
        	ReportInfo reportInfo = iterator.next();
        	int houseId = reportInfo.getReportederId();
        	int flag = houseMapper.selectByIdAndUserId(houseId,user.getId());
        	if(flag == 0){
        		iterator.remove();
        	}
        }
        int num = 0;
        if(reportInfoList.size() >= start){
        	num = Math.min(reportInfoList.size()-start,pageSize);
        }
        for (int i = 0; i < num; i++) {
        	reportInfos.add(reportInfoList.get(start + i));
		}	
        
        if(reportInfos.size() == 0) {
            housePageInfoVo.setSumPage(1);
        }else {
            int sumPage = reportInfos.size();
            housePageInfoVo.setSumPage((sumPage+pageSize-1)/pageSize);
        }
        List<ReportInfoVo> infoVos = new ArrayList<ReportInfoVo>();
        for (int i = 0; i < reportInfos.size(); i++) {
            infoVos.add(reportInfoToReportInfoVo(reportInfos.get(i)));
        }
        housePageInfoVo.setCurPage(pageNum);
        housePageInfoVo.setData(infoVos);
        housePageInfoVo.setPageSize(pageSize);
        
        return ServerResponse.createBySuccess(housePageInfoVo);
	}
	
}
