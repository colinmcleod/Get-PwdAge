function Get-PwdAge {  [CmdletBinding()]             
        Param              
           (                        
               [Parameter(Mandatory=$true, 
                    Position=1)]             
                [String]$Username
            )

Get-ADUser -Filter {
    samaccountname -like $Username 
    -and enabled -eq "True" 
    -and Name -notlike "Guest"
    } `
`
    -Properties pwdlastset `
`
     | select @{
        Name="Full Name";expression={$_.Name}
        },@{
            Name="Login";expression={$_.SamAccountName}
        },@{
            Name="Age In Days";Expression={(New-TimeSpan ([DateTime]::FromFileTime($_.pwdlastset))).Days}
        },@{
            Name="Last Set";Expression={[DateTime]::FromFileTime($_.pwdlastset)}
        } `
`
| Sort-Object -Property "Full Name" `
| Format-Table -Property "Full Name","Login","Age In Days","Last Set"
}