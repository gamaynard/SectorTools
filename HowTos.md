**DATABASE HOW TOs**

This file explains how to execute common administrative tasks for the CCFT database

**DELETE A RECORD**

1. Log in to the server as root. You will be prompted for a password after entering this code
`mysql -u root -p`
2. Select the appropriate database (replace `FYXXXX` with the appropriate name)
`USE FYXXXX;`
3. Look up identifying information (`TransactionNumber`) for the record in the `POTENTIAL_TRANSACTIONS` table, replacing the `...` with a MySQL WHERE clause. 
`SELECT * FROM POTENTIAL_TRANSACTIONS WHERE ...`
4. If the record is in the `SECTOR_LEDGER` table it will need to be deleted there first using the following code and replacing `x` with the TransactionNumber from Step 3. `DELETE FROM SECTOR_LEDGER WHERE TransactionNumber = x;` 
