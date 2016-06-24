
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class Game {
	Player character;
	Scanner scan;
	char input;
	Player[] enemies;
	Scenario checkpoint;
	Scenario current;
	int floor;
	int progress;
	ArrayList<Character> act;
	// Needs to be referenced to access CD
	Connection con;
	// CallableStatement is used for stored procedures
	CallableStatement stmt;
	boolean showExplanations = false;
	StringBuilder explanations = new StringBuilder();

	public Game(Player c) throws SQLException {
		// Make the connection to SQL Server for queries.
		character = c;
		con = ConnectURL.makeConnection();
		scan = new Scanner(System.in);

		// String name = scan.next();
		// character = new Player(c);
		Scenario checkpoint = new Scenario(0, 1);
		current = checkpoint;
		floor = 1;
		progress = 0;
		

		main();
	}

	public void main() throws SQLException {
		floor = character.getFloor();
		progress = character.getRoom();
		if(progress!=0){
			
			current = Scenario.create(progress, floor);
		}
		checkpoint = current;
		while (true) {
			act = getActions();
			System.out.println("Health: " + this.character.getHP() + "/" + this.character.getMaxHP() + " Floor: "
					+ floor + " Progress: " + progress);
			// stringActions() also builds explanations (which will be printed
			// automatically)
			String choices = stringActions();
			System.out.println("Your choices are: " + choices);
			String c = scan.next();
			handleActions(c);
		}
	}

	public ArrayList<Character> getActions() {
		ArrayList<Character> actions = new ArrayList<Character>();
		actions.addAll(current.getActions());
		actions.add('h');
		return actions;
	}

	public String stringActions() {
		StringBuilder sb = new StringBuilder();
		explanations = new StringBuilder();
		if (showExplanations) {
			for (Character c : act) {
				sb.append(c);
				addExplanation(explanations, c);
				sb.append(' ');
			}
		} else {
			for (Character c : act) {
				sb.append(c);
				// addExplanation(explanations, c);
				sb.append(' ');
			}
		}
		// Make the option to show or hide explanations last
		sb.append('s');
		addExplanation(explanations, 's');
		sb.append(' ');
		return sb.toString();
	}

	/**
	 * Adds the appropriate explanation for the character the user can hit for
	 * this round.
	 * 
	 * @param explanations2
	 * @param c
	 */
	private void addExplanation(StringBuilder ex, Character c) {
		if (c.equals('f'))
			System.out.println("Press f to move forward to the next room.  ");
		else if (c.equals('p'))
			System.out.println("Press p to poison a weapon.  ");
		else if (c.equals('s'))
			if (showExplanations)
				System.out.println("Press s to hide these explanations.  ");
			else
				System.out.println("Press s to show the explanations.  ");
		else if (c.equals('l'))
			System.out.println("Press l to move to the room that's left of this room.  ");
		else if (c.equals('r'))
			System.out.println("Press r to move to the room that's right of this room.  ");
		else if (c.equals('b'))
			System.out.println("Press b to go back to the room you came from. ");
		else if (c.equals('h'))
			System.out.println("Press h to see the help screen.  ");
		else if (c.equals('e'))
			System.out.println("Press e to exit the game.  ");
		else if (c.equals('i'))
			System.out.println("Press i to see your inventory of items and weapons.  ");
		else if (c.equals('d'))
			System.out.println("Press d to delete items from your inventory.  ");
		else if (c.equals('z'))
			System.out.println("Press z to save your current state.  ");
		else if (c.equals('0'))
			System.out.println("Press 0 to put an item you found into your inventory.  ");
		else if (c.equals('1'))
			System.out.println("Press 1 to put an item you found into your inventory.  ");
		else if (c.equals('2'))
			System.out.println("Press 2 to put an item you found into your inventory.  ");
		else if (c.equals('3'))
			System.out.println("Press 3 to battle an enemy!  ");
		else if (c.equals('4'))
			System.out.println("Press 4 to battle an enemy!  ");
	}

	/**
	 * Handles when the user enters a character and presses the enter key.
	 * 
	 * @param c
	 * @throws SQLException
	 */
	public void handleActions(String c) throws SQLException {
		ResultSet res;
		StringBuilder str;
		String sql;
		switch (c) {
		case "f":
			if (current.forwardScen != null) {
				current = current.forwardScen;
				progress = current.p;
			} else {
				if (current.forward) {
					progress++;
					current = new Scenario(progress, floor, 'f', current);
				} else {
					System.out.println("You cannot go in that direction");
				}
			}
			break;
		case "b":
			if (current.backScen != null) {
				current = current.backScen;
				progress = current.p;
			} else {
				if (current.back) {
					progress++;
					current = new Scenario(progress, floor, 'b', current);
				} else {
					System.out.println("You cannot go in that direction");
				}
			}
			break;
		case "l":
			if (current.leftScen != null) {
				current = current.leftScen;
				progress = current.p;
			} else {
				if (current.left) {
					progress++;
					current = new Scenario(progress, floor, 'l', current);
				} else {
					System.out.println("You cannot go in that direction");
				}
			}
			break;
		case "r":
			if (current.rightScen != null) {
				current = current.rightScen;
				progress = current.p;
			} else {
				if (current.right) {
					progress++;
					current = new Scenario(progress, floor, 'r', current);
				} else {
					System.out.println("You cannot go in that direction");
				}
			}
			break;
		case "h":
			helpString();
			break;
		case "s":
			showExplanations = !showExplanations;
			break;
		case "i":
			displayInventory();
			displayWeapons(null);
			break;
		// DONE: Ryan make the inventory show up here
		case "d":
			sql = "{call [UpdateItemInInventory] (?,?,?)}";
			stmt = con.prepareCall(sql);
			stmt.setInt(1, character.getInID());

			System.out.println("Insert item ID to update");
			int i = scan.nextInt();
			stmt.setInt(2, i);

			System.out.println("Insert amount to update (negative for removal)");
			i = scan.nextInt();
			stmt.setInt(3, i);

			stmt.executeUpdate();

			System.out.println(i + " items added!");
			break;
		case "u":
			
			
			
			
			
			
			
			// TODO: Next Milestone -- Use items
		case "z":
			sql = "{call [saveState] (?,?,?,?,?)}";
			stmt = con.prepareCall(sql);

			stmt.setInt(1, character.getChID()); // ChID
			stmt.setInt(2, floor); // floor
			stmt.setInt(3, progress); // room
			stmt.setFloat(4, character.getHP()); // temp for actualHP
			stmt.setFloat(5, character.getXP());
			// stmt.setFloat(4, character.actualHP); //actualHP, which is
			// currently commented out, I dont know why
			stmt.executeUpdate();
			System.out.println("Game Saved");
			checkpoint = current;
			break;
		case "p":
			poisonWeapon();
			break;
		case "0":
			if (current.interactibles.get(0).type == 0) {
				character.insertIntoInventory(current.interactibles.get(0).id, "I");
			} else {
				character.insertIntoHas(current.interactibles.get(0).id, this.character.chID);
				// character.insertIntoInventory(current.interactibles.get(0).id,
				// "W");
			}
			current.interactibles.remove(0);
			break;
		case "1":
			if (current.interactibles.get(1).type == 0) {
				character.insertIntoInventory(current.interactibles.get(1).id, "I");
			} else {
				character.insertIntoHas(current.interactibles.get(0).id, this.character.chID);
				// character.insertIntoInventory(current.interactibles.get(1).id,
				// "W");
			}
			current.interactibles.remove(1);
			break;
		case "2":
			if (current.interactibles.get(2).type == 0) {
				character.insertIntoInventory(current.interactibles.get(2).id, "I");
			} else {
				character.insertIntoHas(current.interactibles.get(0).id, this.character.chID);
				// character.insertIntoInventory(current.interactibles.get(2).id,
				// "W");
			}
			current.interactibles.remove(2);
			break;
		case "3":
			new Battle(character, current.enemies.get(0));
			if (character.getHP() <= 0) {
				System.out.println("Starting from checkpoint.");
				current = checkpoint;
				character = new Player(character.getUser(), character.getName());
			}
			else if (current.enemies.get(0).reduceHP(0) <= 0) {
				current.enemies.remove(0);
				current.numberofEnemies--;
			}
			break;
		case "4":
			new Battle(character, current.enemies.get(1));
			if (character.getHP() <= 0) {
				System.out.println("Starting from checkpoint.");
				current = checkpoint;
				character = new Player(character.getUser(), character.getName());
			}
			if (current.enemies.get(1).reduceHP(0) <= 0) {
				current.enemies.remove(1);
				current.numberofEnemies--;
			}
			break;
		case "e":
			scan.close();
			System.out.println("Quitting game");
			System.exit(0);
		case "n":
			if (current.numberofEnemies > 0) {
				System.out.println("You need to fight the boss to advance.");
			} else {
				if (progress == 0) {
					if (floor == 1) {
						System.out.println("There is nothing important to find in the basement.");
					} else {
						if (current.downScen != null) {
							floor--;
							current = current.downScen;
							progress = current.p;
							System.out.println("Going to floor " + floor);
						} else {
							floor--;
							progress = 10;
							System.out.println("Going to floor " + floor);
							Scenario down = Scenario.create(progress, floor);
							current.downScen = down;
							down.upScen = current;
							current = down;
						}
					}
				} else {
					if (current.up) {
						if (current.upScen != null) {
							current = current.upScen;
							floor++;
							progress = current.p;
							System.out.println("Going to floor " + floor);
						} else {
							floor++;
							progress = 0;
							System.out.println("Going to floor " + floor);
							Scenario up = new Scenario(floor, progress);
							current.upScen = up;
							up.downScen = current;
							current = up;
						}
					} else {
						System.out.println("There is no elevator here.");
					}
				}
			}
			break;
		}
	}

	private void displayInventory() throws SQLException {
		String sql = "{call [Display Inventory] (?)}";
		stmt = con.prepareCall(sql);
		stmt.setInt(1, character.getInID());
		ResultSet res = stmt.executeQuery();
		StringBuilder str = new StringBuilder();
		while (res.next()) {
			str.append(res.getString(1));
			str.append(" (");
			str.append(res.getString(2));
			str.append("); ");
		}
		// sql = "{call [Display Inventory2] (?)}";
		// stmt = con.prepareCall(sql);
		// stmt.setInt(1, character.getInID());
		// res = stmt.executeQuery();
		// while (res.next()) {
		// str.append(res.getString(1));
		// str.append(" (");
		// str.append(res.getString(2));
		// str.append("); ");
		// }
		System.out.println(str.toString());
	}

	private HashMap<Integer, Integer> displayPoisons(HashMap<Integer, Integer> displayNumToItID) throws SQLException {
		String sql = "{call displayPoisons (?)}";
		stmt = con.prepareCall(sql);
		stmt.setInt(1, character.getInID());
		ResultSet res = stmt.executeQuery();
		StringBuilder str = new StringBuilder();
		int i = 1;
		while (res.next()) {
			displayNumToItID.put((Integer) i, Integer.parseInt(res.getString(5)));
			str.append(i + ".) " + res.getString(1));
			str.append(" (num: ");
			str.append(res.getString(2));
			str.append(") ");
			str.append("Damage increase (vs. no poison): x1" + res.getString(3).substring(1) + " for weapons of type "
					+ res.getString(4) + ".  ");
			i++;
			System.out.println(str.toString());
			str = new StringBuilder();
		}
		return displayNumToItID;
	}

	private HashMap<Integer, Integer> displayWeapons(HashMap<Integer, Integer> displayNumToWeID) throws SQLException {
		String sql = "{call displayWeapons (?)}";
		stmt = con.prepareCall(sql);
		stmt.setInt(1, this.character.getChID());
		ResultSet res = stmt.executeQuery();
		StringBuilder str = new StringBuilder();
		if (displayNumToWeID == null) {
			while (res.next()) {
				str.append(res.getString(1));
				str.append(". poison: ");
				String poison = res.getString(4);
				if (poison == null)
					str.append("none. ");
				else {
					str.append(poison);
					str.append(", x1" + res.getString(5).substring(1) + " dmg. ");
				}
				str.append(" Type: " + res.getString(6));
				System.out.println(str.toString());
				str = new StringBuilder();
			}
		} else {
			int i = 1;
			while (res.next()) {
				displayNumToWeID.put(i, Integer.parseInt(res.getString(3)));
				str.append(i + ".) " + res.getString(1));
				str.append(". poison: ");
				String poison = res.getString(4);
				if (poison == null)
					str.append("none. ");
				else {
					str.append(poison);
					str.append(", x1" + res.getString(5).substring(1) + " dmg. ");
				}
				i++;
				str.append(" Type: " + res.getString(6));
				System.out.println(str.toString());
				str = new StringBuilder();
			}
		}
		return displayNumToWeID;
	}

	private void poisonWeapon() throws SQLException {
		HashMap<Integer, Integer> displayNumToItID = new HashMap<Integer, Integer>();
		displayNumToItID = displayPoisons(displayNumToItID);
		System.out.println("Enter the number that corresponds to the poison you want to use: (e to exit)");
		String next = scan.next();
		if (next.equals("e"))
			return;
		Integer pNum = Integer.parseInt(next);
		if (!displayNumToItID.containsKey(pNum)) {
			System.out.println("Error: That number does not correspond to a poison");
			return;
		}
		HashMap<Integer, Integer> displayNumToWeID = new HashMap<Integer, Integer>();
		System.out.println("Okay.  Now, here are you weapons: ");
		displayNumToWeID = displayWeapons(displayNumToWeID);
		System.out.println("Enter the number that corresponds to the weapon you want to poison: (e to exit) ");
		next = scan.next();
		if (next.equals("e"))
			return;
		Integer wNum = Integer.parseInt(next);
		if (!displayNumToWeID.containsKey(wNum)) {
			System.out.println("Error: That number does not correspond to a weapon");
			return;
		}
		applyPoison(displayNumToItID.get(pNum), displayNumToWeID.get(wNum));
	}

	private void applyPoison(Integer ItID, Integer WeID) throws SQLException {
		String sql = "{? = call applyPoison (?, ?, ?, ?)}";
		stmt = con.prepareCall(sql);
		stmt.setInt(2, character.chID);
		stmt.setInt(3, ItID);
		stmt.setInt(4, WeID);
		stmt.setInt(5, character.getInID());
		stmt.registerOutParameter(1, Types.INTEGER);
		boolean hadResults = stmt.execute();
		int result = stmt.getInt(1);
		if (result == 1)
			System.out.println("Weapon has been poisoned!");
		else
			System.out.println("Weapon poison cannot poison this type of weapon");
	}

	/**
	 * Used to show help for specific commands.
	 * 
	 * @throws SQLException
	 */
	public void helpString() throws SQLException {
		System.out.println("Which command do you need information on?");
		String c = scan.next();
		CallableStatement cs;
		String b;
		ResultSet res;
		StringBuilder str;
		String sql;
		switch (c) {
		case "f":
			System.out.println("Go forward");
			break;
		case "b":
			System.out.println("Go back");
			break;
		case "l":
			System.out.println("Go left");
			break;
		case "r":
			System.out.println("Go right");
			break;
		case "h":
			System.out.println("This is the help function");
			break;
		case "0":
			if (current.interactibles.get(0).type == 0) {
				cs = con.prepareCall("{call get_Item_Name(?,?)}");
			} else {
				cs = con.prepareCall("{call get_Weapon_Name(?,?)}");
			}
			cs.setInt(1, current.interactibles.get(0).id);
			cs.registerOutParameter(2, Types.VARCHAR);
			cs.execute();
			b = cs.getString(2);
			System.out.println(b);
			break;
		case "1":
			if (current.interactibles.get(1).type == 0) {
				cs = con.prepareCall("{call get_Item_Name(?,?)}");
			} else {
				cs = con.prepareCall("{call get_Weapon_Name(?,?)}");
			}
			cs.setInt(1, current.interactibles.get(1).id);
			cs.registerOutParameter(2, Types.VARCHAR);
			cs.execute();
			b = cs.getString(2);
			System.out.println(b);
			break;
		case "2":
			if (current.interactibles.get(2).type == 0) {
				cs = con.prepareCall("{call get_Item_Name(?,?)}");
			} else {
				cs = con.prepareCall("{call get_Weapon_Name(?,?)}");
			}
			cs.setInt(1, current.interactibles.get(2).id);
			cs.registerOutParameter(2, Types.VARCHAR);
			cs.execute();
			b = cs.getString(2);
			System.out.println(b);
			break;

		case "3":
			System.out.println(current.enemies.get(0).name);
			break;
		case "4":
			System.out.println(current.enemies.get(1).name);
			break;
		}
	}

}
