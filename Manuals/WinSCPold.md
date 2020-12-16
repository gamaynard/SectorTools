# Using an existing WinSCP session to transfer files to the AWS server

1. Open the WinSCP program and double click on the saved session you would like to open. When prompted, enter your password. 
2. Once you are authenticated, you should see two columns of files. On the left are files on your local computer. On the right are files on the server. The directory path on your local machine is underlined in red in the screenshot below. The directory path on the server machine is underlined in blue in the screenshot below. You can navigate through the directories just like you would in Windows File Explorer.

![winSCP3.PNG](/SupportingFiles/WinSCP3.PNG)

3. In this example, we are transferring the file `Hello.txt` from `C:\Users\George\Desktop\TEST` on the local machine to `/home/ubuntu/TEST` on the remote machine. Once you have the directories lined up (local on the left and remote on the right), right click on the file you would like to move to the server and select **UPLOAD**. The file should appear on the right hand side of the screen, on the remote machine. Downloading files from the server is the same as uploading, just start with the file on the right hand side of the screen and select **DOWNLOAD**. 

![winSCP4.PNG](/SupportingFiles/WinSCP4.PNG)


[**Click here to return to the main README file**](/README.md)
