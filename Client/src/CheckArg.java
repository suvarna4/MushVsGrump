
/**
 * Contains the public static method checkArg(String ) which checks the argument
 * for invalid characters, such as semicolons, apostrophes, or -- which could be
 * used in a SQL injection attack. Call this method each time before you pass
 * anything to the DB.
 * 
 * @author localmgr
 *
 */
public class CheckArg {

	/**
	 * Returns true if the argument is a valid SQL command. Returns false if
	 * this argument contains a character which is unnecessary and may possibly
	 * be used for a SQL Injection.
	 * 
	 * @param arg
	 *            - arg that will be passed into SQL
	 * @return true if arg is okay to be passed into SQL
	 */
	public static boolean checkArgValid(String arg) {
		if (arg == null) {
			return true;
		}
		if (arg.contains(";") || arg.contains("'") || arg.contains("--")) {
			return false;
		}
		return true;
	}
}
