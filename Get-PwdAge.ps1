function Get-PwdAge {
    <#
        .SYNOPSIS
            Function that outputs a user(s) password age and the date it was last set.
        .DESCRIPTION

        .EXAMPLE
            Get-PwdAge username

                This will output the users Full Name, SamAccountName, password age in days, 
                and the date/time when the users password was last set.

                    Get-PwdAge username
                        Name                 Login           Age In Days   Last Set                 
                        ----                 -----           -----------   --------                 
                        User Name         username                     6   1/7/2014 12:36:53 PM
        .EXAMPLE
            Get-PwdAge user*

                Adding an asterisk to the username field will do a wild card search
                and output any accounts that match the search. For example -

                    Get-PwdAge Jo*
                        Name                 Login           Age In Days   Last Set                 
                        ----                 -----           -----------   --------                 
                        John Smith           johnsmith                 0   7/8/2014 10:58:38 PM
                        Joe Man              joe.man                 225   11/25/2013 4:14:09 PM
                        Jody Burnham         jodyb                    25   6/14/2014 10:05:29 AM
                        Josh Brolen          joshb                     9   6/29/2014 7:48:51 PM
        .EXAMPLE
            Get-PwdAge *

                Will perform a wild card search that outputs all accounts.

        .PARAMETER Username
            The username to search for.
    #>

  [CmdletBinding()]
        Param
            (
               [Parameter(Mandatory=$true, 
                        Position=1)]
                [String]$Username,
                [String]$OutFile,
                [String]$LogPath,
                [String]$Username
            )

# --- Global Variables --- #
	
	$logStamp = Get-Date -Format 'mm.dd.yyyy hh:mm:ss tt'

# --- Error & Log Handling --- #
	
    function IsNull($object) {

    if (!$object) {
        return $true
    }

    if ($object -is [String] -and $object -eq [String]::Empty) {
        return $true
    }

    if ($object -is [DBNull] -or $object -is [System.Management.Automation.Language.NullString]) {
        return $true
    }

    return $false
    
}
	
function logWrite
	{
		Param ([string]$logstring)
		
		If (IsNull($LogPath) -eq $true)
		{
			$logFolder = "C:\logs"
			$logFile = "Powershell_Get-PwdAge_$($date).log"
			$LogPath = $logFolder + '\' + $logFile
			
			New-Item $logFolder -ItemType directory -ErrorAction SilentlyContinue
			New-Item $LogPath -ItemType file -ErrorAction SilentlyContinue
			
			Add-content $LogPath -value $logstring
		}
		Else
		{
			New-Item $LogPath -ItemType file -ErrorAction SilentlyContinue
			
			Add-content $LogPath -value $logstring
		}
		
	}
	
function sendMail
	{
	    Param ([string]$Subject)
	    
		If (IsNull($SMTP) -eq $true)
		{
			logWrite "$($logStamp): SMTP server not specified, cannot send error notification."
		}
		ElseIf (IsNull($To) -eq $true)
		{
			logWrite "$($logStamp): To address not specified, cannot send error notification."
		}
		Elseif (IsNull($From) -eq $true)
		{
			logWrite "$($logStamp): From address not specified, cannot send error notification."
		}
		Else
		{
			# --- Log this action --- #
			
			logWrite "$($logStamp): Email Notification"
			logWrite "From: $($From)"
			logWrite "To: $($To)"
			logWrite "Subject: $($Subject)"
			
			$Body = Get-Content $LogPath
			$Attachement = $LogPath
			
			# --- Send Message --- #
			
			Send-MailMessage -From $From -To $To -subject $Subject -Body $Body -Attachments $Attachment -Priority High -DeliveryNotificationOption None -smtpServer $SMTP
		}
	}
	
Try {
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
| Sort-Object  -Property "Full Name" `
| Format-Table -Property "Full Name","Login","Age In Days","Last Set"
}
Catch {
    
}
}
}
