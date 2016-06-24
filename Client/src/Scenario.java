import java.sql.CallableStatement;
import java.sql.Types;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.SQLException;

public class Scenario {
	boolean left;
	boolean right;
	boolean forward;
	boolean back;
	boolean up;
	boolean down;
	Scenario leftScen;
	Scenario rightScen;
	Scenario forwardScen;
	Scenario backScen;
	Scenario upScen;
	Scenario downScen;
	char prevDir;
	int numberofEnemies;
	int f;
	int p;
	ArrayList<Interactible> interactibles;
	ArrayList<Enemy> enemies;
	Connection con;

	public Scenario(int progress, int floor, char action, Scenario prevScen) throws SQLException {
		con = ConnectURL.makeConnection();
		left = (Math.random() < .5);
		right = (Math.random() < .5);
		forward = (Math.random() < .5);
		back = (Math.random() < .5);
		prevDir = action;
		p = progress;
		boolean deadend;
		switch (action) {
		case 'l':
			right = true;
			this.rightScen = prevScen;
			prevScen.leftScen = this;
			if (!(left || back || forward)) {
				deadend = true;
				int i = (int) (Math.random()*3);
				if(i ==0){
					left = true;
				}
				else if(i ==1){
					back = true;
				}
				else if(i ==2){
					forward = true;
				}
			}
			break;
		case 'r':
			left = true;
			this.leftScen = prevScen;
			prevScen.rightScen = this;
			if (!(right || back || forward)) {
				deadend = true;
				int i = (int) (Math.random()*3);
				if(i ==0){
					right = true;
				}
				else if(i ==1){
					back = true;
				}
				else if(i ==2){
					forward = true;
				}
			}
			break;
		case 'f':
			back = true;
			this.backScen = prevScen;
			prevScen.forwardScen = this;
			if (!(left || right || forward)) {
				deadend = true;
				int i = (int) (Math.random()*3);
				if(i ==0){
					left = true;
				}
				else if(i ==1){
					right = true;
				}
				else if(i ==2){
					forward = true;
				}
			}
			break;
		case 'b':
			forward = true;
			this.forwardScen = prevScen;
			prevScen.backScen = this;
			if (!(left || back || right)) {
				deadend = true;
				int i = (int) (Math.random()*3);
				if(i ==0){
					left = true;
				}
				else if(i ==1){
					back = true;
				}
				else if(i ==2){
					right = true;
				}
			}
			break;
		}
		f = floor;
		enemies = new ArrayList<Enemy>();
		if (progress % 10 == 0) {
			up = true;
			numberofEnemies = 1;
			CallableStatement cs;
			cs = con.prepareCall("{call getBoss(?, ?)}");
			cs.setInt(1, f);
			cs.registerOutParameter(2, Types.VARCHAR);
			cs.execute();
			String b = cs.getString(2);
			enemies.add(new Enemy(f, b));
		} else {
			numberofEnemies = (int) (Math.random() * 3);
			for (int i = 0; i < numberofEnemies; i++) {
				generateEnemies();
			}
		}
		interactibles = new ArrayList<Interactible>();
		int numofInteracts = (int) (Math.random() * 4);
		for (int i = 0; i < numofInteracts; i++) {
			generateInteractible();
		}

	}

	public static Scenario create(int progress, int floor) throws SQLException {
		ArrayList<Character> c = new ArrayList<Character>();
		int i = (int) (Math.random() * 4);
		c.add('l');
		c.add('f');
		c.add('r');
		c.add('b');
		Scenario newScen;
		Scenario scen;
		if (progress > 1) {
			newScen = Scenario.create(progress -1, floor, c.get(i));			
		} else {
			newScen = new Scenario(progress -1, floor);
		}
		scen = new Scenario(progress, floor, c.get(i), newScen);
		switch(i) {
		case 0:
			newScen.leftScen = scen;
			newScen.left = true;
			break;
		case 1:
			newScen.forwardScen = scen;
			newScen.forward = true;
			break;
		case 2:
			newScen.rightScen = scen;
			newScen.right = true;
			break;
		case 3:
			newScen.backScen = scen;
			newScen.back = true;
			break;
		}
		return scen;
	}
	public static Scenario create(int progress, int floor, char action) throws SQLException {
		ArrayList<Character> c = new ArrayList<Character>();
		int i = (int) (Math.random() * 3);
		if(!(action == 'r')){
			c.add('l');
		}
		if(!(action == 'b')){
			c.add('f');
		}
		if(!(action == 'l')){
			c.add('r');
		}
		if(!(action == 'f')){
			c.add('b');
		}

		Scenario newScen;
		Scenario scen;
		if (progress > 1) {
			newScen = Scenario.create(progress -1, floor, c.get(i));			
		} else {
			newScen = new Scenario(progress -1, floor);
		}
		scen = new Scenario(progress, floor, c.get(i), newScen);
		switch(c.get(i)) {
		case 'l':
			newScen.leftScen = scen;
			newScen.left = true;
			break;
		case 'f':
			newScen.forwardScen = scen;
			newScen.forward = true;
			break;
		case 'r':
			newScen.rightScen = scen;
			newScen.right = true;
			break;
		case 'b':
			newScen.backScen = scen;
			newScen.back = true;
			break;
		}
		return scen;
	}

	public Scenario(int progress, int floor) {
		left = true;
		forward = true;
		right = true;
		down = true;
		numberofEnemies = 0;
		interactibles = new ArrayList<Interactible>();
		enemies = new ArrayList<Enemy>();
	}

	public ArrayList<Character> getActions() {
		ArrayList<Character> actions = new ArrayList<Character>();
		if (p % 10 == 0) {
			actions.add('n');
		}
		if (left)
			actions.add('l');
		if (right)
			actions.add('r');
		if (back)
			actions.add('b');
		if (forward)
			actions.add('f');
		actions.add('i');
		actions.add('p');
		actions.add('d');
		// actions.add('u'); next milestone
		actions.add('z'); // save state of game
		actions.add('e');
		int count = 0;
		for (Interactible c : interactibles) {
			actions.add((char) (count + 48));
			count++;
		}
		count = 0;
		for (Enemy b : enemies) {
			actions.add((char) (count + 51));
			count++;
		}
		return actions;
	}

	public void generateInteractible() throws SQLException {
		CallableStatement cs;
		int a = (int) (Math.random() * 2);
		if (a == 0) {
			cs = con.prepareCall("{call count_Items(?)}");
		} else {
			cs = con.prepareCall("{call count_Weapon(?)}");
		}
		cs.registerOutParameter(1, Types.INTEGER);
		cs.execute();
		int b = cs.getInt(1);
		int c = (int) ((Math.random() * b) + 1);
		interactibles.add(new Interactible(a, c));
	}

	public void generateEnemies() throws SQLException {
		CallableStatement cs;
		cs = con.prepareCall("{call getanEnemy(?)}");
		cs.registerOutParameter(1, Types.VARCHAR);
		cs.execute();
		String b = cs.getString(1);
		enemies.add(new Enemy(f, b));
	}
}
