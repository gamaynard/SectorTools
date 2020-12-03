**DATABASE HOW TOs**

This file explains how to execute common administrative tasks for the CCFT database

**DELETE A RECORD**

1. Log in to the server as root. You will be prompted for a password after entering this code
`mysql -u root -p`
2. Select the appropriate database (replace `FYXXXX` with the appropriate name)
`USE FYXXXX;`
3. Look up identifying information for the record in the `POTENTIAL_TRANSACTIONS` table, replacing the `...` with a MySQL WHERE clause. 
`SELECT * FROM POTENTIAL_TRANSACTIONS WHERE ...`
