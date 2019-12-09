package com.houserss.pojo;

/**    
 * 管理员用户日志类
 * @author cw 
 * @date 2019年3月20日  
 *
 */  
public class UserLog {

    private Integer id;
    
    /**
     * 被操作用户id
     */
    private Integer userId;
    
    /**
     * 操作事件 0登陆   
     */
    private Integer eventId; 
    
    /**
     * 操作时间
     */
    private String logDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getEventId() {
		return eventId;
	}

	public void setEventId(Integer eventId) {
		this.eventId = eventId;
	}

	public String getLogDate() {
		return logDate;
	}

	public void setLogDate(String logDate) {
		this.logDate = logDate;
	}

	public UserLog() {
		super();
		// TODO Auto-generated constructor stub
	}

	public UserLog(Integer id, Integer userId, Integer eventId, String logDate) {
		super();
		this.id = id;
		this.userId = userId;
		this.eventId = eventId;
		this.logDate = logDate;
	}
    
}
