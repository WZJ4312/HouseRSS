package com.houserss.pojo;

public class ReportInfo {

    private Integer id;
    /**
     * 投诉人id
     */
    private Integer reporterId;
    /**
     * 被投诉人id 或者房源id
     */
    private Integer reportederId;
    /**
     * 投诉类型0用户  1房源
     */
    private Integer type;
    /**
     * 投诉时间
     */
    private String reportDate;
    /**
     * 描述
     */
    private String description;
    
    /**
     * 0未删除  1删除
     */
    private Integer status;
    
    /**
     * 0未删除  1删除
     */
    private Integer isSuccess;
    
    
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public Integer getReporterId() {
        return reporterId;
    }
    public void setReporterId(Integer reporterId) {
        this.reporterId = reporterId;
    }
    public Integer getReportederId() {
        return reportederId;
    }
    public void setReportederId(Integer reportederId) {
        this.reportederId = reportederId;
    }
    public Integer getType() {
        return type;
    }
    public void setType(Integer type) {
        this.type = type;
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
    public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getIsSuccess() {
		return isSuccess;
	}
	public void setIsSuccess(Integer isSuccess) {
		this.isSuccess = isSuccess;
	}
	public ReportInfo(Integer id, Integer reporterId, Integer reportederId, Integer type, String reportDate,
			String description, Integer status, Integer isSuccess) {
		super();
		this.id = id;
		this.reporterId = reporterId;
		this.reportederId = reportederId;
		this.type = type;
		this.reportDate = reportDate;
		this.description = description;
		this.status = status;
		this.isSuccess = isSuccess;
	}
	public ReportInfo() {
		super();
		// TODO Auto-generated constructor stub
	}
}
