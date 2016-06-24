import java.io.BufferedReader;
import java.io.Console;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class Main {
	// con must be used to access DB
	static Connection con;
	// CallableStatement is used for stored procedures
	static CallableStatement stmt;

	public static void main(String[] args) throws SQLException {
		// con must be used to access the DB
		con = ConnectURL.makeConnection();
		// next will represent what was last read off the scanner
		String next = null;
		String pass = null;
		Scanner scan = new Scanner(System.in);
		Console console = System.console();

		// pass = new String(console.readPassword("Please enter your password:
		// "));
		System.out.println("Welcome to Mush vs Grump");
		System.out.println("If you are a previous user, please press p then hit enter; if you want to register "
				+ "as a new user, please press r then hit enter");
		next = scan.next();
		String username = null;
		if (next.equals("r")) {
			// If this returns false, it means the registration failed.
			username = LoginAndRegistration.registerNewUser(scan, stmt, con);
			if (username.equals("")) {
				main(args);
				return;
			}
		} else if (next.equals("p")) {
			username = LoginAndRegistration.checkUNameAndPass(scan, stmt, con);
			if (username.equals("")) {
				main(args);
				return;
			}
		} else {
			main(args);
		}
		nextStep(next, scan, username, args);
	}

	private static void nextStep(String next, Scanner scan, String username, String[] args) throws SQLException {
		System.out.println("Press e then enter to exit the game.  ");
		System.out.println("Press n then enter to start a new game (and create a new character).  ");
		System.out.println(
				"Press p then enter to view a list of your previously made characters and type in a character's name to play as that character.  ");
		System.out.println("Press d then enter to delete one of your previously made characters.  ");
		System.out.println("Press l then enter to enter your username and password again");
		next = scan.next();
		if (next.equals("e")) {
			System.out.println("Exiting game");
			scan.close();
			System.exit(0);
		} else if (next.equals("n")) {
			System.out.println("Please enter the name of your new character:");
			scan = new Scanner(System.in);
			next = scan.nextLine();
			boolean valid = CheckArg.checkArgValid(next);
			if (!valid) {
				System.out.println("Invalid character in password.  ' ; -- not allowed");
				nextStep(next, scan, username, args);
				return;
			}
			if (next.length() > 20) {
				System.out.println("Username may not exceed 20 characters");
				nextStep(next, scan, username, args);
				return;
			}
			if (next.equals("")) {
				System.out.println("Your character must have a name!");
				nextStep(next, scan, username, args);
				return;
			}
			String sql = "{? = call newUserCharacter (?, ?)}";
			stmt = con.prepareCall(sql);
			stmt.setString(2, username);
			stmt.setString(3, next);
			stmt.registerOutParameter(1, Types.INTEGER);
			stmt.execute();
			int result = stmt.getInt(1);
			if (result == 0) {
				System.out.println("You already have a character with name " + next + ".");
				nextStep(next, scan, username, args);
				return;
			}
			System.out.println("New character has been created!");
			Game g = new Game(new Player(username, next));
		} else if (next.equals("p")) {
			ArrayList<String> ret = displayCharacters(next, scan, username, args, stmt, con);
			if (ret == null) {
				nextStep(next, scan, username, args);
				return;
			}
			scan = new Scanner(System.in);
			next = scan.nextLine();
			if (next.equals("")) {
				System.out.println("You didn't choose a character");
				main(new String[1]);
			} else if (!ret.contains(next)) {
				System.out.println("This is not a character's name!");
				nextStep(next, scan, username, args);
				return;
			}
			Game g = new Game(new Player(username, next));
		} else if (next.equals("d")) {
			System.out.println("Here are the names of your characters:");
			displayCharacters(next, scan, username, args, stmt, con);
			System.out.println("Type in the name of the character you want to delete:");
			scan = new Scanner(System.in);
			next = scan.nextLine();
			System.out.println("delete: " + next);
			String sql = "{? = call deleteUserCharacter (?, ?)}";
			stmt = con.prepareCall(sql);
			boolean valid = CheckArg.checkArgValid(username);
			if (!valid) {
				System.out.println("Invalid character in input.  ' ; -- not allowed");
				nextStep(next, scan, username, args);
				return;
			}
			valid = CheckArg.checkArgValid(next);
			if (!valid) {
				System.out.println("Invalid character in input.  ' ; -- not allowed");
				nextStep(next, scan, username, args);
				return;
			}
			stmt.setString(2, username);
			stmt.setString(3, next);
			stmt.registerOutParameter(1, Types.INTEGER);
			stmt.execute();
			int result = stmt.getInt(1);
			if (result == 0) {
				System.out.println("You don't have a character of name " + next + ".");
				nextStep(next, scan, username, args);
				return;
			}
			System.out.println("Character " + next + " has been deleted.");
			nextStep(next, scan, username, args);
		} else if (next.equals("l")) {
			main(args);
			return;
		} else {
			System.out.println("Thank you for playing");
			return;
		}
		scan.close();
	}

	static ArrayList<String> displayCharacters(String next, Scanner scan, String username, String[] args,
			CallableStatement stmt2, Connection con2) throws SQLException {
		ArrayList<String> ret = new ArrayList<String>();
		String sql = "{call getUserCharacters (?)}";
		stmt = con.prepareCall(sql);
		stmt.setString(1, username);
		ResultSet res = stmt.executeQuery();
		if (!res.isBeforeFirst()) {
			System.out.println("You have no previously created characters");
			return null;
		}
		while (res.next()) {
			String name = res.getString(1);
			if (name == null || name.equals("") || name.equals("null")) {
				System.out.println("You have no previously created characters");
				return null;
			} else {
				ret.add(name);
				System.out.println(name);
			}
		}
		return ret;
	}
}
