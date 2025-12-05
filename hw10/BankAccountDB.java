/**
 * Implement basic functions of a bank account in the bankdb database.
 *
 * @author
 * @version
 *
 * <p>
 * This class requires that a Transaction object be passed to communicate the
 * desired action.
 * </p>
 *
 * <p>
 * The bank_account table is in the bankdb schema and has this structure:
 * </p>
 * <pre>
 * CREATE TABLE bank_account (
 *    account_id SERIAL,
 *    owner_ssn  VARCHAR(12) NOT NULL,
 *    owner_name VARCHAR(200) NOT NULL,
 *    balance    NUMERIC(12,2) NOT NULL DEFAULT 0.00,
 *    PRIMARY KEY(account_id)
 * )
 * </pre>
 */
import java.sql.*;

class BankAccountDB implements Runnable
{
	private Transaction trans;

	public BankAccountDB(Transaction trans) {
		this.trans= trans;
	}

	/**
	 * Extract transaction details and execute them in the database.
	 */
	public void run()
	{

	}
}
