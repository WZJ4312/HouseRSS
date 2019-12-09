package com.houserss.pojo;

public class User {
    private Integer id;

    /**
     * 账号名
     */
    private String username;
    /**
     * 用户名称
     */
    private String name;

    /**
     * 密码
     */
    private String password;

    /**
     * 邮箱
     */
    private String email;

    /**
     *电话号码 
     */
    private String phone;

    /**
     *用户状态（0正常 1封禁）
     */
    private Integer status;
    
    /**
     * 角色类型
     */
    private Integer roleType;

	public Integer getId() {
		return id;
	}



	public void setId(Integer id) {
		this.id = id;
	}



	public String getUsername() {
		return username;
	}



	public void setUsername(String username) {
		this.username = username;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public String getPhone() {
		return phone;
	}



	public void setPhone(String phone) {
		this.phone = phone;
	}



	public Integer getStatus() {
		return status;
	}



	public void setStatus(Integer status) {
		this.status = status;
	}



	public Integer getRoleType() {
		return roleType;
	}



	public void setRoleType(Integer roleType) {
		this.roleType = roleType;
	}



	public User(Integer id, String username, String name, String password,
			String email, String phone, Integer status, Integer roleType) {
		super();
		this.id = id;
		this.username = username;
		this.name = name;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.status = status;
		this.roleType = roleType;
	}



	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
   
    
}