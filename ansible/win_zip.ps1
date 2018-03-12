#!powershell
# This file is NOT part of Ansible
#
# Copyright 2018, Tj Kellie <tjkellie@roninware.net>
#

# WANT_JSON
# POWERSHELL_COMMON

# TODO: This module is not idempotent (it will always unzip and report change)

$ErrorActionPreference = "Stop"

$params = Parse-Args $args -supports_check_mode $true
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false

$src = Get-AnsibleParam -obj $params -name "src" -type "path" -failifempty $true
$dest = Get-AnsibleParam -obj $params -name "dest" -type "path" -failifempty $true
$creates = Get-AnsibleParam -obj $params -name "creates" -type "path"

$result = @{
    changed = $false
    dest = $dest -replace '\$',''
    src = $src -replace '\$',''
}

Function Create-Zip($src, $dest) {
	try {
		Add-Type -AssemblyName System.IO.Compression.FileSystem | Out-Null
		If(Test-path $dest) {Remove-item $dest}
		[io.compression.zipfile]::CreateFromDirectory($src, $dest) 
		$result.changed = $true
		} catch {
			$result.msg = "Error importing System.IO.Compression.FileSystem"
			Exit-Json -obj $result
		}
	}

If ($creates -and (Test-Path -LiteralPath $creates)) {
    $result.skipped = $true
    $result.msg = "The file '$creates' already exists."
    Exit-Json -obj $result
}

If (-Not (Test-Path -LiteralPath $src)) {
    Fail-Json -obj $result -message "File '$src' does not exist."
}

try {
    Create-Zip -src $src -dest $dest
} catch {
    Fail-Json -obj $result -message "Error zipping '$src' to '$dest'!. Exception: $($_.Exception.Message)"
}

Exit-Json $result
