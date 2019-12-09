package testRegex;

public class TestRegex {

    /**
     * 正则表达式：验证手机号
     */
    public static final String REGEX_MOBILE = "^((17[0-9])|(14[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
 
    /**
     * 正则表达式：验证邮箱
     */
    public static final String REGEX_EMAIL = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
 
    
    public static void main(String[] args) {
        
        
        String email = "243871260@dqq.com";
        System.err.println(email.matches(REGEX_EMAIL));
        String phone = "15960219605";
        System.err.println(phone.matches(REGEX_MOBILE));
        
        
    }
    
}
