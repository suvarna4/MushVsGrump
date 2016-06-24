import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;

public class Player {
	private float baseHP;
	// maxHP is calculated client-side by multiplying baseHP and hpMult
	private float maxHP;
	private float actualHP;
	// private float actualHP;
	private float exp;
	private int level;
	private int floor;
	private int room;
	int chID;
	private int inID;
	private float dmgMult;
	private float hpMult;
	private String weaponName;
	private String weaponPoison;
	private float maxWeaponDmg;
	private String name;
	private String user;
	// con must be used to access DB
	Connection con;
	// CallableStatement is used for stored procedures
	CallableStatement stmt;

	public Player(String username, String chName) throws SQLException {
		// Make the connection to SQL Server for queries.
		user = username;
		name = chName;
		this.con = ConnectURL.makeConnection();
		String sql = "{call getUserCharacter (?, ?)}";
		stmt = con.prepareCall(sql);
		stmt.setString(1, username);
		stmt.setString(2, chName);
		ResultSet res = stmt.executeQuery();
		// Use res.getString to get columns from returned row
		// 1: Actual_hp 2: Base_HP 3: Exp 4: Floor 5: Room
		// 6: ChID 7: InID
		while (res.next()) {
			this.actualHP = Float.parseFloat(res.getString(1));
			this.baseHP = Float.parseFloat(res.getString(2));
			this.exp = Float.parseFloat(res.getString(3));
			this.floor = Integer.parseInt(res.getString(4));
			this.room = Integer.parseInt(res.getString(5));
			this.chID = Integer.parseInt(res.getString(6));
			this.setInID(Integer.parseInt(res.getString(7)));
		}
		setLevel();

		// sql = "{call InsertIntoInventory (?, ?, ?)}";
		//
		// stmt = con.prepareCall(sql);
		// stmt.setInt(1, inID);
		// stmt.setInt(2, 1);
		// stmt.setNString(3, "I");
		// stmt.execute();

		// sql = "{call InsertIntoInventory (inID, 2)}";
		// stmt = con.prepareCall(sql);
		// stmt.executeQuery();
	}

	public void insertIntoInventory(int id, String type) throws SQLException {
		CallableStatement cs = con.prepareCall("{call InsertIntoInventory (?, ?)}");
		cs.setInt(1, getInID());
		cs.setInt(2, id);
		cs.execute();
	}

	public void insertIntoHas(int id, int chID2) throws SQLException {
		CallableStatement cs = con.prepareCall("{call InsertIntoHas (?, ?)}");
		cs.setInt(1, chID2);
		cs.setInt(2, id);
		cs.execute();
	}

	public float getHP() throws SQLException {
		return ((float) Math.round(actualHP*100))/100;
	}

	public void reduceHP(float damage) throws SQLException {
		actualHP = actualHP-damage;
	}

	public void heal(float heal) throws SQLException {
		float hP = getHP() + maxHP * heal;
//		System.out.println(heal);
		if (maxHP < hP) {
			hP = maxHP;
		}
//		System.out.println(hP);
		actualHP = hP;
	}

	public ArrayList<String> getWeapons() throws SQLException {
		ArrayList<String> weapons = new ArrayList<String>();
		stmt = con.prepareCall("{call displayWeapons(?)}");
		stmt.setInt(1, this.chID);
		boolean b = stmt.execute();
		while (b) {
			ResultSet rs = stmt.getResultSet();
			while (rs.next()) {
				weapons.add(rs.getString(1));
			}
			rs.close();
			b = stmt.getMoreResults();
		}
		stmt.close();
		return weapons;
	}

	public ArrayList<String> getItems() throws SQLException {
		ArrayList<String> items = new ArrayList<String>();
		stmt = con.prepareCall("{call getItems(?)}");
		stmt.setInt(1, getInID());
		boolean b = stmt.execute();
		while (b) {
			ResultSet rs = stmt.getResultSet();
			while (rs.next()) {
				items.add(rs.getString("ItName"));
			}
			rs.close();
			b = stmt.getMoreResults();
		}
		stmt.close();
		return items;
	}

	public float getMaxHP() {
		return this.maxHP;
	}

	// public float getActualHP() {
	// return this.actualHP;
	// }

	public int getFloor() {
		return this.floor;
	}

	public void setFloor(int fl) {
		this.floor = fl;
	}

	public int getRoom() {
		return this.room;
	}

	public void setRoom(int rm) {
		this.room = rm;
	}

	public int getChID() {
		return this.chID;
	}

	int getInID() {
		return inID;
	}

	public void setInID(int inID) {
		this.inID = inID;
	}
	
	public void setLevel() throws SQLException {
		int prevlevel = level;
		stmt = con.prepareCall("{call getLevel(?,?,?)}");
		stmt.setInt(1, chID);
		stmt.setFloat(2, exp);
		stmt.registerOutParameter(3, Types.INTEGER);
		stmt.execute();
		level = stmt.getInt(3);
		if(level>prevlevel){
			System.out.println("You have levelled up!");
		}
		String sql = "{call getMultipliersLvl (?)}";
		stmt = con.prepareCall(sql);
		stmt.setInt(1, this.level);
		ResultSet res = stmt.executeQuery();
		while (res.next()) {
			this.dmgMult = Float.parseFloat(res.getString(1));
			this.hpMult = Float.parseFloat(res.getString(2));
		}
		this.maxHP = this.baseHP * this.hpMult;
	}
	
	public float getXP() {
		return exp;
	}
	
	public void setXP(float f) {
		exp+=f;
	}
	
	public float getMult(){
		return dmgMult;
	}

	
	public void setHP(float hp) throws SQLException{
		stmt = con.prepareCall("{call setHP(?,?)}");
		stmt.setInt(1, chID);
		System.out.println(hp);
		stmt.setFloat(2, hp);
		stmt.execute();
	}
	
	public String getName(){
		return name;
		
	}
	
	public String getUser(){
		return user;
	}

}