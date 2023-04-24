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

@WebServlet("/transfer")
public class Transfer extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext ct = req.getServletContext();
		String driver = ct.getInitParameter("driver");
		String url = ct.getInitParameter("url");
		String uname = ct.getInitParameter("uname");
		String dbpwd = ct.getInitParameter("password");
		
		int amount = Integer.parseInt(req.getParameter("amount"));
		int accNumber = Integer.parseInt(req.getParameter("accNumber"));
		int payee = Integer.parseInt(req.getParameter("payee"));
		
		int balance = AxisBalanceDao.currentBalance(accNumber, driver, url, uname, dbpwd);
		System.out.println(balance);
		PrintWriter pw = resp.getWriter();
		if(balance<amount) {
			pw.println("insufficient");
			return;
		}
		balance = balance - amount;
		System.out.println(balance);
		System.out.println(amount);
		AxisBalanceDao.updateBalance(balance, Integer.toString(accNumber), dbpwd, driver, url, uname, dbpwd);
		
		balance = AxisBalanceDao.currentBalance(payee, driver, url, uname, dbpwd);
		balance = balance + amount;
		AxisBalanceDao.updateBalance(balance, Integer.toString(accNumber), dbpwd, driver, url, uname, dbpwd);
		pw.println("success");
		pw.close();
	}
}
