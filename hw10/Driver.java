/**
 * Simulates concurrent creation of multiple accounts followed by various
 * transactions.
 *
 * @author	Terry Sergeant
 * @version for DS
 *
 * <p>
 * We use Transaction objects to communicate our intent with the various BankAccountDB
 * threads.
 * </p>
*/

import java.sql.*;

public class Driver
{
	public static void main(String [] args) throws Exception
	{
		final int NUM_WORKERS= 42;
		final int NUM_ACCOUNTS= 7;
		//CodeTimer timer= new CodeTimer();
		Thread [] spool= new Thread[NUM_WORKERS];
		Transaction [] create= new Transaction[NUM_ACCOUNTS];
		Connection con;
		Statement stmt;
		int i;

		// Establish account creation objects
		create[0]= new Transaction("123-12-1234", "Fred", 1000.00);
		create[1]= new Transaction("234-23-2345", "Mary", 1000.00);
		create[2]= new Transaction("345-34-3456", "Amy", 1000.00);
		create[3]= new Transaction("456-45-4567", "Zach", 1000.00);
		create[4]= new Transaction("567-56-5678", "Alice", 1000.00);
		create[5]= new Transaction("678-67-6789", "Abe", 1000.00);
		create[6]= new Transaction("789-78-7890", "Greta", 1000.00);

		// Create BankAccountDB worker threads to carry out account creation.
		// When this code finishes create[i].account_id will have the account
		// id numbers that were created.
		for (i=0; i<NUM_ACCOUNTS; i++) {
			spool[i]= new Thread(new BankAccountDB(create[i]));
			spool[i].start();
		}
		for (i=0; i<NUM_ACCOUNTS; i++) {
			spool[i].join();
		}
		for (i=0; i<NUM_ACCOUNTS; i++) {
			System.out.println(create[i].account_id);
		}

		// We add $100.00 to everyone's account 6 times ... so new total should be
		// $1,600.00 for everyone after these actions finish
		for (i=0; i<NUM_ACCOUNTS; i++) {
			spool[i]= new Thread(new BankAccountDB(new Transaction(create[i].account_id, 100.00, "deposit")));
			spool[i+7]= new Thread(new BankAccountDB(new Transaction(create[i].account_id, 100.00, "deposit")));
			spool[i+14]= new Thread(new BankAccountDB(new Transaction(create[i].account_id, 100.00, "deposit")));
			spool[i+21]= new Thread(new BankAccountDB(new Transaction(create[i].account_id, 100.00, "deposit")));
			spool[i+28]= new Thread(new BankAccountDB(new Transaction(create[i].account_id, 100.00, "deposit")));
			spool[i+35]= new Thread(new BankAccountDB(new Transaction(create[i].account_id, 100.00, "deposit")));
		}
		for (i=0; i<NUM_WORKERS; i++) {
			spool[i].start();
		}
		for (i=0; i<NUM_WORKERS; i++) {
			spool[i].join();
		}

		// We transfer $123.00 from everyone's account to everyone else's account.
		// So, should be at $1,600.00 for everyone again after these actions finish.
		int j,n;
		n= 0;
		for (i=0; i<NUM_ACCOUNTS-1; i++) {
			for (j=i+1; j<NUM_ACCOUNTS; j++) {
				spool[n]= new Thread(new BankAccountDB(new Transaction(create[i].account_id, create[j].account_id, 123.00)));
				n++;
				spool[n]= new Thread(new BankAccountDB(new Transaction(create[j].account_id, create[i].account_id, 123.00)));
				n++;
			}
		}
		for (i=0; i<NUM_WORKERS; i++) {
			spool[i].start();
		}
		for (i=0; i<NUM_WORKERS; i++) {
			spool[i].join();
		}

		// We remove $175.00 from the first thread 10 times. The last withdrawal
		// should fail because of insufficient fund so the account should end with
		// $25.00
		for (i=0; i<10; i++) {
			spool[i]= new Thread(new BankAccountDB(new Transaction(create[0].account_id, 175.00, "withdrawal")));
			spool[i].start();
		}
		for (i=0; i<10; i++) {
			spool[i].join();
		}

		// So, at end of program we expect the first account to have $25.00 and
		// the rest of the accounts to have $1,600.00
	}
}
