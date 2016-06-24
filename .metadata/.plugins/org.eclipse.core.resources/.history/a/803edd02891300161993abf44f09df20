import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Scanner;

public class Battle {
	Player p;
	Enemy e;
	Connection con;
	int b = 0;
	Scanner scan;
	ArrayList<Float> r;
	String wep;
	public Battle(Player c, Enemy b) throws SQLException{
		p = c;
		e=b;
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
	public void main() throws SQLException{
		boolean j = true;
		while(j){
			System.out.println(e.name + " has " + e.reduceHP(0) + " HP.");
			System.out.println("You have " + p.getHP() + " HP." );
			System.out.println("What would you like to do?");
			System.out.println("(a)ttack, (i)tem, (f)lee");
			String c = scan.next();
			if(c == "f"){
				b = 2;
				j = false;
				break;
			}
			else if(c.equals("a")){
				handleWeapons();
			}
			else {
				handleItems();
			}
			
			if(e.reduceHP(0)<=0){
				j = false;
			}
			else {
				CallableStatement cs = con.prepareCall("{call getAttackandDamage(?,?,?)}");
				cs.setString(1, wep);
				cs.registerOutParameter(2, Types.VARCHAR);
				cs.registerOutParameter(3, Types.REAL);
				cs.execute();
				System.out.println(e.name + " used " + cs.getString(2));
				float f = Float.parseFloat(cs.getString(3));
				p.reduceHP(f);
			}
			if(p.getHP()<=0){
				b=1;
				j=false;
			}
		}
		if(b==2){
			System.out.println("You fleed the battle.");
		}
		if(b==1){
			System.out.println("You are defeated.");
		}
		if(b==0){
			System.out.println("You are victorious");
			System.out.println("You have gained " + e.maxHP()+ " XP.");
		}
	}
	public void handleWeapons() throws SQLException{
		System.out.println("You currently own: ");
		int count = 0;
		ArrayList<String> d = p.getWeapons();
		for(String c: d){
			System.out.println(count + " " + c);
			count++;
		}
		System.out.println("Choose your weapon.");
		int i = scan.nextInt();
		CallableStatement cs = con.prepareCall("{call getAttackandDamage(?,?,?)}");
		cs.setString(1, d.get(i));
		cs.registerOutParameter(2, Types.VARCHAR);
		cs.registerOutParameter(3, Types.REAL);
		cs.execute();
		System.out.println("You used " + cs.getString(2));
		float f = Float.parseFloat(cs.getString(3));
		cs = con.prepareCall("{call getWeaponType(?)}");
		cs.setString(1, d.get(i) );
		boolean b = cs.execute();
		while(b){
			ResultSet rs = cs.getResultSet();
			while(rs.next()){
				if(rs.getString("WeaponType").equals("melee")){
					f=f*r.get(0);
				}
				else if(rs.getString("WeaponType").equals("blade")){
					f=f*r.get(1);
				}
				else if(rs.getString("WeaponType").equals("blunt")){
					f=f*r.get(2);
				}
				else if(rs.getString("WeaponType").equals("ranged")){
					f=f*r.get(3);
				}
			}
			rs.close();
			b = cs.getMoreResults();
		}
		cs.close();
		e.reduceHP(f);
		
	}
	public void handleItems() throws SQLException{
		System.out.println("You currently own: ");
		int count = 0;
		ArrayList<String> d = p.getItems();
		for(String c: d){
			System.out.println(count + " " + c);
			count++;
		}
		System.out.println("Choose your item.");
		int i = scan.nextInt();
		CallableStatement cs = con.prepareCall("{call getTypeandPotency(?,?,?)}");
		cs.setString(1, d.get(i));
		cs.registerOutParameter(2, Types.INTEGER);
		cs.registerOutParameter(3, Types.FLOAT);
		cs.execute();
		float f = cs.getFloat(3);
		if(cs.getInt(2)==1){
			p.heal(f);
		}
		else {
			cs = con.prepareCall("{call getAffects(?,?)}");
			System.out.println(d.get(i));
			cs.setString(1,  d.get(i));
			cs.registerOutParameter(2, Types.VARCHAR);
			cs.execute();
			System.out.println(cs.getString(2));
			if(cs.getString(2).equals("melee")){
				r.set(0, r.get(0)*f);
			}
			else if(cs.getString(2).equals("blade")){
				r.set(1, r.get(1)*f);
			}
			else if(cs.getString(2).equals("blunt")){
				r.set(2, r.get(2)*f);
			}
			else if(cs.getString(2).equals("ranged")){
				r.set(3, r.get(3)*f);
			}
		}
	}

	
}
