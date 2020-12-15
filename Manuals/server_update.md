# How to keep the Ubuntu operating system up to date

1. Log in to the AWS server with PuTTY
2. If upgrades are necessary, you will see the following message after you log in

`X updates can be installed immediately`

`X of these updates are security updates`

3. To queue the updates, enter the following code
`sudo apt update`
4. To apply the updates, enter the following code (depending on the number of updates, this can be fairly time consume)
`sudo apt upgrade`
5. To clean up any unnecessary files, enter the following code
`sudo apt autoremove`


[**Click here to return to the main README file**](/README.md)
