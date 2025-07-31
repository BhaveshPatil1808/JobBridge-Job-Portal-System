package com.jobportal;

import java.sql.Connection;
import java.sql.DriverManager;

public class Dbconnection {
	private static final String URL = "jdbc:mysql://localhost:3306/test";
    private static final String USER = "root";
    private static final String PASS = "rcpit";
	public static Connection connect(){
		Connection con=null;
		
        try {
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		con = DriverManager.getConnection(URL,USER,PASS);
    	}catch (Exception e) {
			// TODO: handle exception
    		System.out.println(e.getMessage());
		}
		
		return con;
	}

}
