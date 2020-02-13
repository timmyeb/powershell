#requires -version 3
<#
.SYNOPSIS
    Verifies the integrity of a file using the MD5 checksum.
.NOTES
    Author:         Timmy Elfstrand
.EXAMPLE
$hash = (Get-FileHash -Algorithm MD5 C:\example.txt ).hash
.\Verify-File -Path C:\example.txt -ReferenceHash $hash

.LINK
    https://github.com/timmyeb/powershell
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$Path,
 
    [Parameter(Mandatory = $true)]
    [string]
    $ReferenceHash

)
Begin {
    $ErrorActionPreference = 'Stop'
}

Process {
    $LocalHash = (Get-FileHash -Path $Path -Algorithm MD5).Hash
}

End {
    if ($ReferenceHash -ne $LocalHash) {
        Write-Error "The local file is incomplete, path: $Path"
    }
    Write-Output "Sucsessfully verified the integrity of local file, path: $Path"
}