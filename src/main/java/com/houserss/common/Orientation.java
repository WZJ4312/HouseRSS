package com.houserss.common;

/**
 * 朝向
 * @author cw
 *
 */
public enum Orientation {

    /**
     * 东
     */
    EAST(0),
    /**
     * 南
     */
    SOUTH(1),
    /**
     * 西
     */
    WEST(2),
    /**
     * 北
     */
    NORTH(3),
    /**
     * 东南
     */
    SOUTHEAST(4),
    /**
     * 东北
     */
    NORTHEAST(5),
    /**
     * 西南
     */
    SOUTHWEST(6),
    /**
     * 西北
     */
    NORTHWEST(7);
    
    private int code;
    Orientation(int code) {
        this.code = code;
    }
    public int getCode() {
        return code;
    }
    public void setCode(int code) {
        this.code = code;
    }
    
    
}
