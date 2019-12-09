package com.houserss.vo;

public class ReportInfoVo {
    private int id;
    /**
     * 投诉人id
     */
    private int reporterId;
    /**
     * 投诉人名称
     */
    private String reporterUsername;
    /**
     * 被投诉人id
     */
    private int reportederId;
    /**
     * 被投诉用户名称
     */
    private String username;
    /**
     * 标题
     */
    private String title; 
    /**
     * 投诉时间
     */
    private String reportDate;
    /**
     * 描述
     */
    private String description;
    /**
     * 处理状态(0处理中 1投诉成功 2投诉失败)
     */
    private int status;
    
    
    
    public int getId() {
        return id;
    }



    public void setId(int id) {
        this.id = id;
    }



    public int getReporterId() {
        return reporterId;
    }



    public void setReporterId(int reporterId) {
        this.reporterId = reporterId;
    }



    public String getReporterUsername() {
        return reporterUsername;
    }



    public void setReporterUsername(String reporterUsername) {
        this.reporterUsername = reporterUsername;
    }



    public int getReportederId() {
        return reportederId;
    }



    public void setReportederId(int reportederId) {
        this.reportederId = reportederId;
    }



    public String getUsername() {
        return username;
    }



    public void setUsername(String username) {
        this.username = username;
    }



    public String getTitle() {
        return title;
    }



    public void setTitle(String title) {
        this.title = title;
    }



    public String getReportDate() {
        return reportDate;
    }



    public void setReportDate(String reportDate) {
        this.reportDate = reportDate;
    }



    public String getDescription() {
        return description;
    }



    public void setDescription(String description) {
        this.description = description;
    }



    public int getStatus() {
        return status;
    }



    public void setStatus(int status) {
        this.status = status;
    }



    public ReportInfoVo() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
    
}
