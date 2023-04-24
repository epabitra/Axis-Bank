package com.axisbank.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.axisbank.beans.CustomerBean;
import com.axisbank.dao.CustomerDao;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/modify")
public class ModifyCustomer extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext ct = req.getServletContext();
		String driver = ct.getInitParameter("driver");
		String url = ct.getInitParameter("url");
		String uname = ct.getInitParameter("uname");
		String dbpwd = ct.getInitParameter("password");
		
		HttpSession hs = req.getSession();
		int accNumber = (int)hs.getAttribute("accNumber");
		
		String firstName = req.getParameter("fname");
		String lastName = req.getParameter("lname");
		String email = req.getParameter("email");
		String dob = req.getParameter("dob");
		String phone = req.getParameter("phone");
		String nominee = req.getParameter("nominee");
		String password = req.getParameter("password");
		String rePassword = req.getParameter("re-password");
		
		boolean flag = emptyValidation(firstName, lastName, email, dob, phone, nominee, password, rePassword);
		if(flag) {
			flag=passwordValidation(password, rePassword);
			if(flag) {
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date ud = null;
				try {
					ud = sdf.parse(dob);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				java.sql.Date sqd= new java.sql.Date(ud.getTime());
				
				CustomerBean bean = new CustomerBean(firstName, lastName, email, sqd, phone, nominee, password);
				int status = CustomerDao.updateCustomer(bean, driver, url, uname, dbpwd, accNumber);
				if(status == -1) {
					PrintWriter pw = resp.getWriter();
					pw.println("error");
				}else {
					PrintWriter pw = resp.getWriter();
					pw.println("success");
				}
			}else {
				PrintWriter pw = resp.getWriter();
				pw.println("mismatch");
			}
		}else {
			PrintWriter pw = resp.getWriter();
			pw.print("empty");
			return;
		}
	}
	
	public boolean emptyValidation(String firstName, String lastName, String email, String dob, String phone, String nominee, String password, String rePassword) {
		if(firstName.equals(""))
			return false;
		if(lastName.equals(""))
			return false;
		if(email.equals(""))
			return false;
		if(dob.equals(""))
			return false;
		if(phone.equals(""))
			return false;
		if(nominee.equals(""))
			return false;
		if(password.equals(""))
			return false;
		if(rePassword.equals("")) {
			return false;
		}

		return true;
	}
	public boolean passwordValidation(String password, String rePassword) {
		if(password.equals(rePassword)) {
			return true;
		}else {
			return false;
		}
	}
}
