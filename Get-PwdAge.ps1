function Get-PwdAge { [CmdletBinding()] Param ([Parameter(Mandatory=$false, Position=1, ValueFromPipeline=$false, ValueFromPipelineByPropertyName=$false)][String]$Username)

Get-ADUser -Filter {samaccountname -like $Username -and enabled -eq "True"} -Properties pwdlastset | select @{Name="Employee Name";expression={$_.Name}},@{Name="Login";expression={$_.SamAccountName}},@{Name="Age In Days";Expression={(New-TimeSpan ([DateTime]::FromFileTime($_.pwdlastset))).Days}},@{Name="Last Set";Expression={[DateTime]::FromFileTime($_.pwdlastset)}} | ft

}
