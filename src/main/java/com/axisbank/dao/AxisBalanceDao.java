package com.axisbank.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AxisBalanceDao {
	public static int createBook(int accNumber, String driver, String url, String uname, String password) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(url, uname, password);
			ps = con.prepareStatement("INSERT INTO AXISBALANCE VALUES("+accNumber+",500)");
			return ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(ps!=null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return -1;
	}
	
	public static int updateBalance(int amount, String accNumber, String operation, String driver, String url, String uname, String password) {
		Connection con = null;
		PreparedStatement ps = null;
		int status = -1;
		try {
			int balance;
			con = DriverManager.getConnection(url, uname, password);
			Statement st = con.createStatement();
			String retrieveQuery = "SELECT BALANCE FROM AXISBALANCE WHERE ACCNUMBER = "+accNumber;
			String updateQuery = "UPDATE AXISBALANCE SET BALANCE=? WHERE ACCNUMBER=?";
			System.out.println(retrieveQuery);
			System.out.println(updateQuery);
			ResultSet rs = st.executeQuery(retrieveQuery);
			System.out.println("Before Amount :: "+amount);
			if(rs.next()) {
				balance = rs.getInt(1);
				if(operation.equals("plus")) {
					amount = balance+amount;
				}else {
					amount = balance - amount;
				}				
			}
			System.out.println("After Amount :: "+amount);
		
			ps = con.prepareStatement(updateQuery);
			ps.setInt(1, amount);
			ps.setString(2, accNumber);
			status = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(ps!=null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		if(status == 1) {
			return amount;
		}else {
			System.out.println(status);
			return status;
		}
	}
	
	public static int currentBalance(int accNumber, String driver, String url, String uname, String password) {
		int balance = 0;
		try {
			Class.forName(driver);
			Connection con = DriverManager.getConnection(url, uname, password);
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT BALANCE FROM AXISBALANCE WHERE ACCNUMBER = "+accNumber);
			if(rs.next()) {
				balance = rs.getInt(1);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException se) {
			se.printStackTrace();
		}
		return balance;
	}
}
