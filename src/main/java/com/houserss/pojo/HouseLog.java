package com.houserss.pojo;

/**    
 * 管理员房屋日志类
 * @author cw 
 * @date 2019年3月20日  
 *
 */  
public class HouseLog {

    private int id;
    
    /**
     * 被操作房源id
     */
    private int houseId;
    
    /**
     * 操作事件 发布时间
     */
    private int eventId; 
    
    /**
     * 操作时间
     */
    private String logDate;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getHouseId() {
        return houseId;
    }

    public void setHouseId(int houseId) {
        this.houseId = houseId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getLogDate() {
        return logDate;
    }

    public void setLogDate(String logDate) {
        this.logDate = logDate;
    }

    public HouseLog(int id, int houseId, int eventId, String logDate) {
        super();
        this.id = id;
        this.houseId = houseId;
        this.eventId = eventId;
        this.logDate = logDate;
    }

    public HouseLog() {
        super();
        // TODO Auto-generated constructor stub
    }
    
}
