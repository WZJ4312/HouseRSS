package com.houserss.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

public class StartUpServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7706053448796526088L;

	public void destroy() {
		super.destroy();
	}
	
	public void init() throws ServletException {
		this.getServletContext().setAttribute("ctx", this.getServletContext().getContextPath());
	}
	
}
