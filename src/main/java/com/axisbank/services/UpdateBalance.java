package com.axisbank.services;

import java.io.IOException;
import java.io.PrintWriter;

import com.axisbank.dao.AxisBalanceDao;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateBalance")
public class UpdateBalance extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext ct = req.getServletContext();
		String driver = ct.getInitParameter("driver");
		String url = ct.getInitParameter("url");
		String uname = ct.getInitParameter("uname");
		String dbpwd = ct.getInitParameter("password");
		
		int amount = Integer.parseInt(req.getParameter("amount"));
		String accNumber = req.getParameter("accNumber");
		String operation = req.getParameter("operation");
		amount = AxisBalanceDao.updateBalance(amount, accNumber, operation, driver, url, uname, dbpwd);
		PrintWriter pw = resp.getWriter();
		pw.print(amount);
	}
}
