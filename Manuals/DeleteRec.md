# How to delete a transaction record from the database

1. Log in to the MySQL server as root. You will be prompted for a password after entering this code
`mysql -u root -p`
2. Select the appropriate database (replace `FYXXXX` with the appropriate name)
`USE FYXXXX;`
3. Look up identifying information (`TransactionNumber`) for the record in the `POTENTIAL_TRANSACTIONS` table, replacing the `...` with a MySQL WHERE clause. 
`SELECT * FROM POTENTIAL_TRANSACTIONS WHERE ... ;`
4. If the record is in the `SECTOR_LEDGER` table it will need to be deleted there first using the following code and replacing `x` with the TransactionNumber from Step 3. `DELETE FROM SECTOR_LEDGER WHERE TransactionNumber = x;` If the record hasn't been added to the ledger yet, you can skip this step. 
5. Now, the record can be deleted from the `POTENTIAL_TRANSACTIONS` table using the following code and replacing `x` with the TransactionNumber from Step 3. `DELETE FROM POTENTIAL_TRANSACTIONS WHERE TransactionNumber = x;`

As long as you haven't seen any error messages, you should be good to go at this point. If you want to double check, you can run the first query (`SELECT * FROM POTENTIAL_TRANSACTIONS WHERE ... ;` from Step 3. If the record has been removed, you should get the following response from the server. `Empty set (0.00 sec)`. Now, you can close your connection to the server using the following code `exit;`

[**Click here to return to the main README file**](/README.md)
