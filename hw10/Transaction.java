/**
 * Stores information necessary to carry out a transaction.
 *
 * @author T.Sergeant
 * @version for DB
 *
 * <p>
 * A transaction object is built to communicate to a bank account what database
 * actions needs to take place. Each type of transaction requires that different
 * values be set. When a transaction is completed it is expected that the
 * transaction object will be updated to reflect (success or failure). NOTE:
 * the values expected to be set are not set here, but by the code that uses
 * this class.
 * </p>
 * <p>
 * Supported transaction codes:
 * </p>
 * <pre>
 * create - creates a new bank account
 *   requires : owner_ssn, owner_name, amount (which represents initial balance)
 *   to be set: account_id and result (true on success false on failure)
 *
 * deposit - deposit specified amount to the given account
 *   requires : account_id, amount, transaction_type ("deposit")
 *   to be set: result (true on success false on failure)
 *
 * withdrawal - withdraws specified amount from given account
 *   requires : account_id, amount, transaction_type ("withdrawal")
 *   to be set: result (true on success false on failure)
 *
 * transfer - transfers specified amount from one account to another
 *   requires : account_id, dest_account_id, amount
 *   to be set: result (true on success false on failure)
 * </pre>
 */

public class Transaction
{
	private String transaction_type;
	public int account_id;
	public String owner_ssn;
	public String owner_name;
	public double amount;
	public int dest_account_id;
	public boolean result;


	/**
	 * Constructor to be called to setup a "create" Transaction.
	 *
	 * @param owner_ssn Social security number of owner of the new account.
	 * @param owner_name Name of owner of the new account.
	 * @param amount Amount of the initial deposit for the new account.
	 */
	public Transaction(String owner_ssn, String owner_name, double amount) {
		this.transaction_type= "create";
		this.owner_ssn= owner_ssn;
		this.owner_name= owner_name;
		this.amount= amount;
	}


	/**
	 * Constructor to be called to setup a "deposit" or "withdrawal" Transaction.
	 *
	 * @param account_id The database id of the account we are using.
	 * @param amount The amount of the deposit or withdrawal.
	 * @param type Must be one of "deposit" or "withdrawal".
	 */
	public Transaction(int account_id, double amount, String type) {
		if (!type.equals("deposit") && !type.equals("withdrawal")) {
			System.err.println("Invalid transaction type: " + type);
			System.exit(1);
		}
		this.transaction_type= type;
		this.account_id= account_id;
		this.amount= amount;
	}


	/**
	 * Constructor to be called to setup a "transfer" Transaction.
	 *
	 * @param account_id The database id of the account we are transferring from.
	 * @param dest_account_id The database id of the account we are transferring to.
	 * @param amount The amount of the transfer.
	 * @param type Must be one of "deposit" or "withdrawal".
	 */
	public Transaction(int account_id, int dest_account_id, double amount) {
		this.transaction_type= "transfer";
		this.account_id= account_id;
		this.dest_account_id= dest_account_id;
		this.amount= amount;
	}


	/**
	 * Semi-intelligently returns the transaction details.
	 *
	 * @return a string with transaction details.
	 */
	public String toString() {
		if (transaction_type.equals("create")) {
			return String.format("Create account for %s (%s) with initial deposit of $%1.2f",
					owner_name, owner_ssn, amount);
		}
		else if (transaction_type.equals("deposit")) {
			return String.format("Deposit $%1.2f into account %d", amount, account_id);
		}
		else if (transaction_type.equals("withdrawal")) {
			return String.format("Withdraw $%1.2f from account %d", amount, account_id);
		}
		else if (transaction_type.equals("transfer")) {
			return String.format("Transfer $%1.2f from account %d to account %d",
					amount, account_id, dest_account_id);
		}
		else {
			return "Invalid transaction";
		}
	}


	/**
	 * Checks type of the transaction.
	 *
	 * @param type desired transaction type
	 * @return true if type parameter matches this transaction's type; false otherwise.
	 */
	public boolean is(String type) {
		return transaction_type.equals(type);
	}
}
