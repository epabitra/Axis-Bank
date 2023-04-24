package com.axisbank.services;

import java.io.IOException;
import java.io.PrintWriter;

import com.axisbank.beans.CustomerBean;
import com.axisbank.dao.CustomerDao;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class Login extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext ct = req.getServletContext();
		String driver = ct.getInitParameter("driver");
		String url = ct.getInitParameter("url");
		String uname = ct.getInitParameter("uname");
		String dbpwd = ct.getInitParameter("password");
		
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		
		int accNumber = CustomerDao.login(email, password, driver, url, uname, dbpwd);
		CustomerBean bean = CustomerDao.details(accNumber, driver, url, uname, dbpwd);
		
		PrintWriter pw = resp.getWriter();
		
		if(accNumber != -1) {
			HttpSession hs = req.getSession();
			hs.setAttribute("accNumber", accNumber);
			hs.setAttribute("firstName", bean.getFirstName());
			hs.setAttribute("lastName", bean.getLastName());
			hs.setAttribute("email", bean.getEmail());
			hs.setAttribute("phone", bean.getPhone());
			hs.setAttribute("dob", bean.getDob());
			hs.setAttribute("nominee", bean.getNominiName());
			hs.setAttribute("password", password);
			pw.print("success");
			pw.close();
		}else {
			pw.print("not-found");
			pw.close();
		}
	}

}
