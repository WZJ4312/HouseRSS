package com.houserss.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeUtils {

    public final static int DAY_SECONDS = 86400;
    public final static int HOUR_SECONDS = 3600;
    public final static int DAY_MILLIS = DAY_SECONDS * 1000;
    public final static int HOUR_MILLIS = HOUR_SECONDS * 1000;
    
    /**
     * 获取今日日期，如： 2019-03-05
     * @return
     */
    public static String getDayTime() {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
        return df.format(new Date());
    }
    /**
     * 获取当前业务开始时的1970-01-01 00:00:00到当前的秒数
     */
    public static int currentSecond() {
        return (int) (currentTimeMillis() / 1000);
    }
    
    /**
     * 获取当前业务开始时的1970-01-01 00:00:00到当前的毫秒数
     */
    public static long currentTimeMillis() {
        return System.currentTimeMillis();
    }
    
}
