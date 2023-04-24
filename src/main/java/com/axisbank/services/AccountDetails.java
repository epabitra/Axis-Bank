package com.axisbank.services;

import java.io.IOException;

import com.axisbank.beans.CustomerBean;
import com.axisbank.dao.CustomerDao;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/details")
public class AccountDetails extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private String accNumber;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext ct = req.getServletContext();
		String driver = ct.getInitParameter("driver");
		String url = ct.getInitParameter("url");
		String uname = ct.getInitParameter("uname");
		String password = ct.getInitParameter("password");
		
		HttpSession hs = req.getSession();		
		int accNumber = (int)hs.getAttribute("accNumber");
//		System.out.println(accNumber); 
		
		CustomerBean bean = CustomerDao.details(accNumber, driver, url, uname, password);
//		System.out.println(bean);

		req.setAttribute("accNumber", "03941080226"+accNumber);
		req.setAttribute("name", bean.getFirstName()+" "+bean.getLastName());
		req.setAttribute("email", bean.getEmail());
		req.setAttribute("dob", bean.getDob());
		req.setAttribute("phone", bean.getPhone());
		req.setAttribute("nominee", bean.getNominiName());
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
