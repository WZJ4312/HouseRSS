package com.houserss.common;

/**
 * 户型
 * @author cw
 *
 */
public enum HouseType {
    /**
     * 一室
     */
    ONEROOM(0),
    /**
     * 二室
     */
    TWOROOM(1),
    /**
     * 三室
     */
    THREEROOM(2),
    /**
     * 四室
     */
    FOURROOM(3),
    /**
     * 五室
     */
    FIVEROOM(4),
    /**
     * 五室以上
     */
    MOREFIVEROOM(5);
    
    private int code;
    HouseType(int code) {
        this.code = code;
    }
    public int getCode() {
        return code;
    }
    public void setCode(int code) {
        this.code = code;
    }
    
}
