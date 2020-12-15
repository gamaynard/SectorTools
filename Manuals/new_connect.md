# Creating a new connection to an AWS server

This process may seem a little intimidating, but you only need to do it once to set up a connection between a windows machine and the server. 

1. Download the PuTTY terminal emulator program [here](https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.74-installer.msi) and install it on your Windows machine. *NOTE: If the linked installer for Windows 10 64-bit systems doesn't work on your PC, you can select the appropriate installer from the list [here](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)*
2. Log in to the AWS Management Console with the CCCFA credentials and select the EC2 option.

![aws_homescreen.PNG](/SupportingFiles/aws1.PNG)

3. On the left-hand side of the EC2 screen, under **NETWORK & SECURITY** select the **Key Pairs** option.

![aws_EC2screen.PNG](/SupportingFiles/aws2.PNG)

4. Click on the orange **CREATE KEY PAIR** button in the top right corner of the screen and you should see the options below. Enter a name that describes the computer being used. For example, you could use the computer's name on the CCCFA network (`"HOOK-##"`) or something along those lines. Be sure that you've selected the correct key type for use with PuTTY (.ppk) and press the orange **CREATE KEY PAIR** button to create the keys. You will be prompted to save the private key in a safe place. 

```diff
- WARNING: THIS IS YOUR ONLY CHANCE TO DOWNLOAD AND SAVE THE PRIVATE KEY SO DO NOT IGNORE IT OR LOSE THE FILE
```

![aws_createKeyPair.PNG](/SupportingFiles/aws3.PNG)

5. Launch the puttygen.exe program from your start menu. The easiest way to do this is just to type `puttygen.exe` into the Windows start menu search. On the opening screen, select the **SSH-1(RSA)** option, then press **LOAD**.

![puttygen1.PNG](/SupportingFiles/puttygen1.PNG)

6. Select the private key file you downloaded before and you will see the key and the key fingerprint show up in the puttygen box. Press the **SAVE PRIVATE KEY** button and save the resulting file with a `.ppk` extension. This is the key you will use to connect to the server through PuTTY.

![puttygen2.PNG](/SupportingFiles/puttygen2.PNG)

7. Open PuTTY. The user interface in PuTTY is pretty clunky, but I promise we're almost done setting up the connection, so just bear with me. In the session menu, fill out the **HOSTNAME** and **PORT** fields as follows, taking care to change the **CONNECTION TYPE** filed to SSH:

![putty1.PNG](/SupportingFiles/putty1.PNG)

8. Expand the SSH menu in the PuTTY sidebar and select **AUTH**. Next to the box at the bottom of the screen labeled **PRIVATE KEY FILE FOR AUTHORIZATION**, select the **BROWSE** button and navigate to the .ppk file we saved in step 6. 

![putty2.PNG](/SupportingFiles/putty2.PNG)

```diff
- WARNING: ONCE YOU'VE SELECTED THE .PPK FILE, DO NOT PRESS ENTER OR PRESS THE OPEN BUTTON IN THE MAIN PUTTY WINDOW OR YOU WILL NEED TO REPEAT THIS PROCESS
```

9. In the sidebar menu, navigate back to **SESSION**. Enter a name for these settings in the **SAVED SESSIONS** box, and press **SAVE**. Now, you should be able to double click the name of your saved session in the **SAVED SESSIONS** box to open a text-only interface into the server. 

[**Click here to return to the main README file**](/README.md)
