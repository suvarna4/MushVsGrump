import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Scanner;

public class LoginAndRegistration {
	protected static String checkUNameAndPass(Scanner scan, CallableStatement stmt, Connection con)
			throws SQLException {
		System.out.println("Please enter your username");
		String next;
		char[] passc;
		String pass;
		next = scan.next();
		System.out.println("Please enter your password");
		// pass = scan.next();
		// Uncomment this for Windows terminal
		passc = System.console().readPassword();
		pass = String.valueOf(passc);
		// Sanitize DB args
		if (!CheckArg.checkArgValid(next)) {
			System.out.println("Invalid character in username.  ' ; --  not allowed.");
			return "";
		}
		if (!CheckArg.checkArgValid(pass)) {
			System.out.println("Invalid character in password.  ' ; -- not allowed");
			return "";
		} // Now we we can call the SP
		String sql = "{? = call checkUNameAndPass (?, ?)}";
		stmt = con.prepareCall(sql);
		stmt.setString(2, next);
		stmt.setString(3, pass);
		stmt.registerOutParameter(1, Types.INTEGER);
		stmt.execute();
		int result = stmt.getInt(1);
		if (result == 1) {
			System.out.println("This username and password combination does not exist");
			return "";
		}
		return next;
	}

	protected static String registerNewUser(Scanner scan, CallableStatement stmt, Connection con) throws SQLException {
		String pass;
		String next;
		System.out.println("Please enter a username");
		next = scan.next();
		if (!CheckArg.checkArgValid(next)) {
			System.out.println("Invalid character in username.  ' ; --  not allowed.");
			Main.main(new String[1]);
		}
		String sql = "{? = call checkUName (?)}";
		// con = ConnectURL.makeConnection();
		stmt = con.prepareCall(sql);
		stmt.setString(2, next);
		stmt.registerOutParameter(1, Types.INTEGER);
		boolean hadResults = stmt.execute();
		int result = stmt.getInt(1);
		if (result == 1) {
			System.out.println("The username " + next + " already exists.");
			Main.main(new String[1]);
		}
		System.out.println("Please enter a password (it will be hidden)");
		// pass = scan.next();
		// Uncomment this for Windows terminal
		char[] passc = System.console().readPassword();
		pass = String.valueOf(passc);
		System.out.println("Please enter the password again");
		// String passAgain = scan.next();
		// Uncomment this for Windows terminal
		char[] passcAgain = System.console().readPassword();
		String passAgain = String.valueOf(passcAgain);
		if (!pass.equals(passAgain)) {
			System.out.println("Your passwords did not match");
			Main.main(new String[1]);
			return "";
		}
		if (!CheckArg.checkArgValid(pass)) {
			System.out.println("Invalid character in password.  ' ; -- not allowed");
			Main.main(new String[1]);
			return "";
		}
		sql = "{? = call registerNewUser (?, ?)}";
		stmt = con.prepareCall(sql);
		stmt.setString(2, next);
		stmt.setString(3, pass);
		stmt.registerOutParameter(1, Types.INTEGER);
		if (!CheckArg.checkArgValid(pass)) {
			System.out.println("Invalid character in password.  ' ; -- not allowed");
			Main.main(new String[1]);
			return "";
		}
		hadResults = stmt.execute();
		int results = stmt.getInt(1);
		if (results == 1) {
			System.out.println("The username " + next + " already exists.");
			Main.main(new String[1]);
			return "";
		}
		System.out.println("Registration successful!");
		return next;
	}
}
