package com.houserss.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.houserss.pojo.ReportInfo;

public interface ReportInfoMapper {

    int insert(ReportInfo reportInfo);
    
    List<ReportInfo> selectBytype(@Param("start")int start,@Param("end")int end,@Param("type")int type,
    		@Param("status")int status,@Param("userId")int userId,@Param("isSuccess")int isSuccess);
    
    int selectCountBytype(@Param("type")int type,@Param("status")int status,@Param("userId")int userId,
    		@Param("isSuccess")int isSuccess);
    
    ReportInfo selectById(@Param("id")int id);
    
    ReportInfo updateReport(@Param("id")int id, @Param("status")int status);
    
    int deleteById(@Param("id")int id);
    
    int updateStatus(@Param("id")int id, @Param("status")int status,@Param("isSuccess")int isSuccess);
    
    List<ReportInfo> getSucessReport(@Param("isSuccess")int isSuccess,@Param("type")int type);
    
}
