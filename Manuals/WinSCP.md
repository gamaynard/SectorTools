# Using WinSCP to transfer files to and from the server

WinSCP is a secure file transfer program that allows users to move files back and forth between Windows desktops and Linux servers. Setting up a WinSCP connection can be a somewhat daunting experience (similar to setting up a PuTTY connection), but once it's done, it should be usable long-term. In order to set up a WinSCP connection, you will need to install WinSCP from the [website here](https://winscp.net/eng/index.php). Once you have the program installed, follow the steps below to set up your connection. 

1. Click on the **NEW SITE** button to create a new session
2. The **File Protocol** and **Port** parameters should already be set to `SFTP` and `22` respectively, so no changes need to be made there. 
3. The **Hostname** is `fisheriestrust.xyz` and the **User name** is `ubuntu`
4. Once you have all of that information set, press the **ADVANCED** button to bring up an additional dialogue

![WinSCP1.PNG](/SupportingFiles/winSCP1.PNG)

5. Under the advanced settings, use the left hand menu to navigate to the **SSH --> Authentication** item. 
6. Use the **...** button in the **Private key file** dialogue box to navigate to the same .ppk file we used to connect through PuTTY

![WinSCP2.PNG](/SupportingFiles/winSCP2.PNG)

7. Press **OK** which should return you to the main screen where you can press **SAVE** and name your session when prompted. 
