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
             Display Name         user1                   6 1/7/2014 12:36:53 PM

```Get-PwdAge user*``` ```Get-PwdAge u*```

Will do a wildcard search and return any accounts that match the search.

         Get-PwdAge u*
             Name                 Login           AgeInDays LastSet                 
             ----                 -----           --------- -------                 
             Display Name         user1                   6 1/7/2014 12:36:53 PM
             Display Name         user2                  17 2/6/2014 12:36:53 PM
             Display Name         user3                  10 2/7/2014 12:36:53 PM
             Display Name         user4                  33 2/7/2014 12:36:53 PM
             Display Name         user5                  0  2/7/2014 12:36:53 PM

```Get-PwdAge *```

Will return the password age information for all accounts excluding disabled accounts.

```Get-PwdAge -All```

Will return the password age information for all accounts including disabled accounts.

```Get-PwdAge -Disabled```

Will return the password age information for all disabled accounts.

