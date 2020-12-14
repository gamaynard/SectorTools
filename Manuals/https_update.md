## Keeping the HTTPS certificate up to date

In order to keep login information on the server secure, we need to make sure that the login pages use HTTPS (Hypertext Transfer Protocol Secure) instead of HTTP. To keep the "S" in HTTPS, we must maintain a certificate. One way the certificates ensure security is by expiring every 90 days, which necessitates updating them before that expiration date occurs. All of the HTTPS certificates for our domains are managed through a software package called ["CERTBOT"](https://certbot.eff.org/) developed by the Electronic Frontier Foundation, a leading non-profit advocacy group for internet privacy and security.  

To keep the certificates up to date, you will need to log in to the server terminal through PuTTY. Start an administrator session by entering the command `sudo su` then start the cerbot program by typing `certbot`. Press enter to renew the certificates. If prompted to expand the certificate, type `E` and press <Enter> to do so. When prompted to redirect HTTP traffic to HTTPS, type `2` and press <Enter> to do so. Once the certificate has renewed, you should see the following confirmation message. Note that the next expiration date is listed in the confirmation message. 
  
![certbot_screenshot.png](/SupportingFiles/CERTBOT-confirmation.PNG)

To ensure everything is working correctly, visit the [testing page run by SSL Labs](https://www.ssllabs.com/ssltest/analyze.html?d=www.fisheriestrust.xyz) and you should get the following output.

![SSL_Labs_screenshot.png](/SupportingFiles/SSL.PNG)
