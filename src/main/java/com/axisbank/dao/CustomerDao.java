package com.axisbank.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.axisbank.beans.CustomerBean;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CustomerDao {

	// Save method started
	public static boolean save(CustomerBean bean, HttpServletRequest req, HttpServletResponse resp) {
		int status = 0;
		Connection con = null;
		PreparedStatement ps = null;
		try {
			ServletContext ct = req.getServletContext();
			String driver = ct.getInitParameter("driver");
			String url = ct.getInitParameter("url");
			String uname = ct.getInitParameter("uname");
			String password = ct.getInitParameter("password");
			Class.forName(driver);
			con = DriverManager.getConnection(url,uname,password);
			ps = con
					.prepareStatement("INSERT INTO CUSTOMER VALUES(CUSTOMERS_SEQ.NEXTVAL,?,?,?,?,?,?,?)");
			ps.setString(1, bean.getFirstName());
			ps.setString(2, bean.getLastName());
			ps.setString(3, bean.getEmail());
			ps.setDate(4, bean.getDob());
			ps.setString(5, bean.getPhone());
			ps.setString(6, bean.getNominiName());
			ps.setString(7, bean.getPassword());
			status = ps.executeUpdate();
			if(status == 1) {
				resp.sendRedirect("login.html?success=User Created Successfully");
			}
		} catch (SQLException se) {
			String firstName = req.getParameter("fname");
			String lastName = req.getParameter("lname");
			String email = req.getParameter("email");
			String dob = req.getParameter("dob");
			String phone = req.getParameter("phone");
			String nominee = req.getParameter("nominee");
			String password = req.getParameter("password");
			String rePassword = req.getParameter("re-password");
			req.setAttribute("fname",firstName);
			req.setAttribute("lname", lastName);
			req.setAttribute("email", email);
			req.setAttribute("dob", dob);
			req.setAttribute("phone", phone);
			req.setAttribute("nominee", nominee);
			req.setAttribute("password", password);
			req.setAttribute("errorMsg", "Email Already Exist");
			try {
				req.getRequestDispatcher("register.jsp?header=Register User&operation=Create Account&action=register").forward(req, resp);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
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

		if (status!=1) {
			System.out.println("Some exception occured when saving the user and Status = "+status);
		}

		return true;
	}
	// Save method End
	
	// Login method Start
	public static int login(String email, String password, String driver, String url, String uname, String dbpwd) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, uname, dbpwd);
			ps = con.prepareStatement("SELECT ACCNUMBER FROM CUSTOMER WHERE EMAIL=? AND PASSWORD=?");
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}else {
				return -1;
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	// Login method End
	
	// Details method Start
	public static CustomerBean details(int accNumber, String driver, String url, String uname, String password) {
		Connection con = null;
		PreparedStatement ps = null;
		String firstName;
		String lastName;
		String email;
		String phone;
		java.sql.Date dob;
		String nominee;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,uname,password);
			ps = con.prepareStatement("SELECT * FROM CUSTOMER WHERE ACCNUMBER=?");
			ps.setInt(1, accNumber);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				firstName = rs.getString(2);
				lastName = rs.getString(3);
				email = rs.getString(4);
				dob = rs.getDate(5);
				phone = rs.getString(6);
				nominee = rs.getString(7);
				CustomerBean bean = new CustomerBean(firstName, lastName, email, dob, phone, nominee, null);
				return bean;
			}			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	// Details method End
	
	// Update User Method Start
	public static int updateCustomer(CustomerBean bean, String driver, String url, String uname, String dbpwd, int accNumber) {
		int status = 0;
		Connection con = null;
		PreparedStatement ps = null;
		try {
			
			Class.forName(driver);
			con = DriverManager.getConnection(url,uname,dbpwd);
			ps = con
					.prepareStatement(" UPDATE CUSTOMER SET FIRSTNAME=?, LASTNAME=?, EMAIL=?, DOB=?, PHONE=?, NOMINEE=?, PASSWORD=? WHERE ACCNUMBER=?");
			ps.setString(1, bean.getFirstName());
			ps.setString(2, bean.getLastName());
			ps.setString(3, bean.getEmail());
			ps.setDate(4, bean.getDob());
			ps.setString(5, bean.getPhone());
			ps.setString(6, bean.getNominiName());
			ps.setString(7, bean.getPassword());
			ps.setInt(8, accNumber);
			status = ps.executeUpdate();
			if(status == 1) {
				return 1;
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
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

		if (status!=1) {
			System.out.println("Some exception occured when saving the user and Status = "+status);
		}

		return status;
	}

}
