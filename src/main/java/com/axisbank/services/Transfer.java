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
		System.out.println("<========= Transfer Transaction Started ===========>");
		int amount = Integer.parseInt(req.getParameter("amount"));
		int accNumber = Integer.parseInt(req.getParameter("accNumber"));
		int payee = Integer.parseInt(req.getParameter("payee"));
		
		int balance = AxisBalanceDao.currentBalance(accNumber, driver, url, uname, dbpwd);
		System.out.println("Account Holder Current Balance :: "+balance);
		PrintWriter pw = resp.getWriter();
		if(balance<amount) {
			pw.println("insufficient");
			return;
		}
		System.out.println("Withdra Request for :: "+amount);
		AxisBalanceDao.updateBalance(amount, Integer.toString(accNumber), "minus", driver, url, uname, dbpwd);
		
		System.out.println("Deposit Request for :: "+amount);
		AxisBalanceDao.updateBalance(amount, Integer.toString(payee), "plus", driver, url, uname, dbpwd);
		pw.println("success");
		pw.close();
	}
}
