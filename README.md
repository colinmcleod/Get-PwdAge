Get-PwdAge
==========

Joe Glessner's Get-PwdAge PowerShell script - http://joeit.wordpress.com/

### Description
This Function will query AD for password age. It can display information for a specified user, all users, disabled users only, and enabled/disabled users combined.

### Syntax

```Get-PwdAge user1```

Will return password age information for the user "user1"

         Get-PwdAge user1
             Name                 Login           AgeInDays LastSet                 
             ----                 -----           --------- -------                 
             Display Name         user1                   6 2/7/2007 12:36:53 PM

```Get-PwdAge -All``` ```Get-PwdAge *```
