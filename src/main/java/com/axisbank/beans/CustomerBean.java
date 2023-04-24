package com.axisbank.beans;

public class CustomerBean {

	private String firstName;
	private String lastName;
	private String email;
	private java.sql.Date dob;
	private String phone;
	private String nominiName;
	private String password;
	
	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public java.sql.Date getDob() {
		return dob;
	}

	public void setDob(java.sql.Date dob) {
		this.dob = dob;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getNominiName() {
		return nominiName;
	}

	public void setNominiName(String nominiName) {
		this.nominiName = nominiName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public CustomerBean(String firstName, String lastName, String email, java.sql.Date dob, String phone, String nominiName,
			String password) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.dob = dob;
		this.phone = phone;
		this.nominiName = nominiName;
		this.password = password;
	}

	@Override
	public String toString() {
		return "CustomerBean [firstName=" + firstName + ", lastName=" + lastName + ", email=" + email + ", dob=" + dob
				+ ", phone=" + phone + ", nominiName=" + nominiName + ", password=" + password + "]";
	}
	
}
