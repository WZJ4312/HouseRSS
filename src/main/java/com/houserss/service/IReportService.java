package com.houserss.service;

import com.houserss.common.ServerResponse;
import com.houserss.pojo.ReportInfo;
import com.houserss.pojo.User;
import com.houserss.vo.PageInfoVo;
import com.houserss.vo.ReportInfoVo;

public interface IReportService {
    ServerResponse<String> report(ReportInfo reportInfo);
    
    ServerResponse<PageInfoVo<ReportInfoVo>> selectReportInfo(int pageNum,int pageSize,int type,int status,User user);
    
    ServerResponse<PageInfoVo<ReportInfoVo>> selectHouseReportInfo(int pageNum,int pageSize,int type,User user);
    
    ServerResponse<String> dealReport(int id,int status);
}
