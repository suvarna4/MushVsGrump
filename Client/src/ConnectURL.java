
//
//  File:    connectURL.java      
//  Summary: This Microsoft JDBC Driver for SQL Server sample application
//	     demonstrates how to connect to a SQL Server database by using
//	     a connection URL. It also demonstrates how to retrieve data 
//	     from a SQL Server database by using an SQL statement.
//
//---------------------------------------------------------------------
//
//  This file is part of the Microsoft JDBC Driver for SQL Server Code Samples.
//  Copyright (C) Microsoft Corporation.  All rights reserved.
//
//  This source code is intended only as a supplement to Microsoft
//  Development Tools and/or on-line documentation.  See these other
//  materials for detailed information regarding Microsoft code samples.
//
//  THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
//  ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO 
//  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
//  PARTICULAR PURPOSE.
//
//===================================================================== 

import java.sql.*;

import com.microsoft.sqlserver.jdbc.SQLServerDataSource;

/**
 * Contains the method makeConnection(), which should be placed in the
 * constructor of any Class which needs to access the DB. This allows DB access.
 * 
 * @author localmgr
 *
 */
public class ConnectURL {

	public static void main(String[] args) {
	}

	/**
	 * Call this method to make a connection to the DB.
	 * 
	 * @return
	 * @throws SQLException
	 */
	public static Connection makeConnection() throws SQLException {

		// Create a variable for the connection string.
		String connectionUrl = "jdbc:sqlserver://137.112.104.37:1433;" + "databaseName=MushVsGrump;"
				+ "user=mush;password=texasrules;";

		// Declare the JDBC objects.
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;

		try {
			SQLServerDataSource ds = new SQLServerDataSource();

			// Establish the connection.
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con = DriverManager.getConnection(connectionUrl);
			// con = ds.getConnection();

			// // Create and execute an SQL statement that returns some data.
			// String SQL = "SELECT TOP 10 * FROM Character";
			// stmt = con.createStatement();
			// rs = stmt.executeQuery(SQL);
			// System.out.println("i am here");
			// // Iterate through the data in the result set and display it.
			// while (rs.next()) {
			// System.out.println(rs.getString(4) + " " + rs.getString(6));
			// }

			// System.out.println("Please enter your username");
			// // char[] password = r.readPassword(
			// // "Please enter your password", username);
			// System.out.println("Please enter your password");
			// // Sanitize DB args
			// System.out.println("Creating statement...");
			// String sql = "{call checkUNameAndPass (?, ?)}";
			// stmt = con.prepareCall(sql);
			// stmt.setString(1, "max");
			// stmt.setString(2, "morgan");
			// System.out.println("before stmt execute()");
			// boolean hadResults = stmt.execute();
			// System.out.println("hadResults: " + hadResults);
			// // Process all returned result sets
			// while (hadResults) {
			// rs = stmt.getResultSet();
			// System.out.println("rs: " + rs);
			// }
			// process result set

			// hadResults = stmt.getMoreResults();

			return con;
		}

		// Handle any errors that may have occurred.
		catch (Exception e) {
			e.printStackTrace();
		}
		return con;

		// finally {
		// if (rs != null)
		// try {
		// rs.close();
		// } catch (Exception e) {
		// }
		// if (stmt != null)
		// try {
		// stmt.close();
		// } catch (Exception e) {
		// }
		// if (con != null)
		// try {
		// con.close();
		// } catch (Exception e) {
		// }
		// }

	}
}
