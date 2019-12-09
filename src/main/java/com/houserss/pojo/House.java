package com.houserss.pojo;

public class House {

    private Integer id;
    
    private Integer sellType;//租售类型0租  1售
    
    private String zone;// 区域
    
    private Integer houseType;//户型
    
    private Integer price;//价格
    
    private Integer orientation;//朝向
    
    private Integer floor;//楼层
    
    private String title; // 标题
    
    private Integer decorateType;//装修类型 0毛坯1普通装修2精装修3高级装修
    
    private String decoration;//描述
    
    private Integer area;//面积
    
    private String address;//地址

    private Integer userId;// 所属用户id

    private String imageInfos; // 图片信息
    
    private Integer isHide; // 是否隐藏  0显示 1隐藏
    
    private String reason; //审核失败的原因
    
    private Integer status; // 状态 0审核中 1审核成功  2 审核失败 3删除房源
    
    private String publishDate; // 发布时间

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSellType() {
        return sellType;
    }

    public void setSellType(Integer sellType) {
        this.sellType = sellType;
    }

    public String getZone() {
        return zone;
    }

    public void setZone(String zone) {
        this.zone = zone;
    }

    public Integer getHouseType() {
        return houseType;
    }

    public void setHouseType(Integer houseType) {
        this.houseType = houseType;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getOrientation() {
        return orientation;
    }

    public void setOrientation(Integer orientation) {
        this.orientation = orientation;
    }

    public Integer getFloor() {
        return floor;
    }

    public void setFloor(Integer floor) {
        this.floor = floor;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getDecorateType() {
        return decorateType;
    }

    public void setDecorateType(Integer decorateType) {
        this.decorateType = decorateType;
    }

    public String getDecoration() {
        return decoration;
    }

    public void setDecoration(String decoration) {
        this.decoration = decoration;
    }

    public Integer getArea() {
        return area;
    }

    public void setArea(Integer area) {
        this.area = area;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getImageInfos() {
        return imageInfos;
    }

    public void setImageInfos(String imageInfos) {
        this.imageInfos = imageInfos;
    }

    public String getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Integer getIsHide() {
        return isHide;
    }

    public void setIsHide(Integer isHide) {
        this.isHide = isHide;
    }

    public House(Integer id, Integer sellType, String zone, Integer houseType, Integer price, Integer orientation,
            Integer floor, String title, Integer decorateType, String decoration, Integer area, String address,
            Integer userId, String imageInfos, Integer isHide, String reason, Integer status, String publishDate) {
        super();
        this.id = id;
        this.sellType = sellType;
        this.zone = zone;
        this.houseType = houseType;
        this.price = price;
        this.orientation = orientation;
        this.floor = floor;
        this.title = title;
        this.decorateType = decorateType;
        this.decoration = decoration;
        this.area = area;
        this.address = address;
        this.userId = userId;
        this.imageInfos = imageInfos;
        this.isHide = isHide;
        this.reason = reason;
        this.status = status;
        this.publishDate = publishDate;
    }

    public House() {
        super();
        // TODO Auto-generated constructor stub
    }


    
    
}
