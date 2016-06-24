import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;
<<<<<<< HEAD
//import org.apache.commons.lang.math.NumberUtils;
=======
>>>>>>> parent of ec25026... Just kidding, you cannot quite heal from a battle. going to have to modify a lot of stuff :(

public class Battle {
	Player p;
	Enemy e;
	Connection con;
	int b = 0;
	Scanner scan;
	ArrayList<Float> r;
	String wep;

	public Battle(Player c, Enemy b) throws SQLException {
		p = c;
		e = b;
		System.out.println("You are fighting: " + b.name);
		this.con = ConnectURL.makeConnection();
		CallableStatement cs = con.prepareCall("{call get_Weapon_Name(?,?)}");
		cs.setInt(1, b.getWeapon());
		cs.registerOutParameter(2, Types.VARCHAR);
		cs.execute();
		System.out.println(b.name + " is wielding " + cs.getString(2));
		wep = cs.getString(2);
		scan = new Scanner(System.in);
		r = new ArrayList<Float>();
		r.add((float) 1);
		r.add((float) 1);
		r.add((float) 1);
		r.add((float) 1);
		main();
	}

	public void main() throws SQLException {
		boolean j = true;
		while (j) {
			System.out.println(e.name + " has " + e.reduceHP(0) + " HP.");
			System.out.println("You have " + p.getHP() + " HP.");
			System.out.println("What would you like to do?");
			System.out.println("(a)ttack, (i)tem, (f)lee");
			String c = scan.next();
			if (c == "f") {
				b = 2;
				j = false;
			} else if (c.equals("a")) {
				handleWeapons();
			} else {
				handleItems();
			}

			if (e.reduceHP(0) <= 0) {
				j = false;
			} else {
				CallableStatement cs = con.prepareCall("{call getAttackandDamage(?,?,?)}");
				cs.setString(1, wep);
				cs.registerOutParameter(2, Types.VARCHAR);
				cs.registerOutParameter(3, Types.REAL);
				cs.execute();
				System.out.println(e.name + " used " + cs.getString(2));
				float f = Float.parseFloat(cs.getString(3));
				p.reduceHP(f);
			}
			if (p.getHP() <= 0) {
				b = 1;
				j = false;
			}
		}
		if (b == 2) {
			System.out.println("You fled the battle.");
		}
		if (b == 1) {
			System.out.println("You are defeated.");
		}
		if (b == 0) {
			System.out.println("You are victorious");
			System.out.println("You have gained " + e.maxHP() + " XP.");
		}
	}

	public void handleWeapons() throws SQLException {
		System.out.println("You currently own: ");
		int count = 0;
		ArrayList<String> d = p.getWeapons();
		for (String c : d) {
			System.out.println(count + " " + c);
			count++;
		}
		System.out.println("Choose your weapon.");
		int i = scan.nextInt();
		System.out.println("i: " + i + "d: " + d);
		CallableStatement cs = con.prepareCall("{call getAttackandDamage(?,?,?)}");
		cs.setString(1, d.get(i));
		cs.registerOutParameter(2, Types.VARCHAR);
		cs.registerOutParameter(3, Types.REAL);
		cs.execute();
		System.out.println("You used " + cs.getString(2));
		float f = Float.parseFloat(cs.getString(3));
		cs.close();
		e.reduceHP(f);

	}

	public void handleItems() throws SQLException {
		System.out.println("You currently own: ");
		int count = 0;
		ArrayList<String> d = p.getItems();
		for (String c : d) {
			System.out.println(count + " " + c);
			count++;
		}
		System.out.println("Choose your item.");
		int i = scan.nextInt();
		CallableStatement cs = con.prepareCall("{call getTypeandPotency(?, ?, ?,?)}");
		cs.setString(1, d.get(i));
		cs.setInt(2, this.p.getInID());
		cs.registerOutParameter(3, Types.INTEGER);
		cs.registerOutParameter(4, Types.FLOAT);
		cs.execute();
		float f = cs.getFloat(3);
<<<<<<< HEAD
		if (i < 5) {
			p.heal(f);
		} else if (cs.getInt(2) <= Integer.MAX_VALUE) {
=======
		if(cs.getInt(2) < 5){
			System.out.println("dsafjlkdsajfljdsaf;ljdsa;lfjdsaf;ljdsa;lfj;ldsaf");
			p.heal(cs.getInt(2));
		}
		else {
>>>>>>> parent of ec25026... Just kidding, you cannot quite heal from a battle. going to have to modify a lot of stuff :(
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
<<<<<<< HEAD
		} else {
			System.out.println("Invalid input");
=======
>>>>>>> parent of ec25026... Just kidding, you cannot quite heal from a battle. going to have to modify a lot of stuff :(
		}
	}

	private HashMap<Integer, Integer> displayWeapons(HashMap<Integer, Integer> displayNumToWeID) throws SQLException {
		String sql = "{call displayWeapons (?)}";
		CallableStatement stmt;
		stmt = con.prepareCall(sql);
		stmt.setInt(1, p.getChID());
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
			}
		}
		System.out.println(str.toString());
		return displayNumToWeID;
	}

	private void applyPoison(Integer ItID, Integer WeID) throws SQLException {
		String sql = "{? = call applyPoison (?, ?, ?, ?)}";
		CallableStatement stmt;
		stmt = con.prepareCall(sql);
		stmt.setInt(2, p.chID);
		stmt.setInt(3, ItID);
		stmt.setInt(4, WeID);
		stmt.setInt(5, p.getInID());
		stmt.registerOutParameter(1, Types.INTEGER);
		boolean hadResults = stmt.execute();
		int result = stmt.getInt(1);
		if (result == 1)
			System.out.println("Weapon has been poisoned!");
		else
			System.out.println("Weapon poison cannot poison this type of weapon");
	}

	private HashMap<Integer, Integer> displayPoisons(HashMap<Integer, Integer> displayNumToItID) throws SQLException {
		String sql = "{call displayPoisons (?)}";
		CallableStatement stmt = con.prepareCall(sql);
		stmt.setInt(1, p.getInID());
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
		}
		System.out.println(str.toString());
		return displayNumToItID;
	}

}
