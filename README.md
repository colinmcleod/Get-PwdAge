Get-PwdAge
==========

### Syntax

```Get-PwdAge username```

This will output the users Full Name, SamAccountName, password age in days, and the date/time when the users password was last set.

         Get-PwdAge username
             Name                 Login           Age In Days   Last Set                 
             ----                 -----           -----------   --------                 
             User Name         username                     6   1/7/2014 12:36:53 PM
            


```Get-PwdAge user*```

Adding an asterisk to the username field will do a wild card search and output any accounts that match the search. For example -

         Get-PwdAge Jo*
             Name                 Login           Age In Days   Last Set                 
             ----                 -----           -----------   --------                 
             John Smith           johnsmith                 0   7/8/2014 10:58:38 PM
             Joe Man              joe.man                 225   11/25/2013 4:14:09 PM
             Jody Burnham         jodyb                    25   6/14/2014 10:05:29 AM
             Josh Brolen          joshb                     9   6/29/2014 7:48:51 PM

```Get-PwdAge *```

Will perform a wild card search that outputs all accounts.
