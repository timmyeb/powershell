function Test-Administrator {
	$user = [Security.Principal.WindowsIdentity]::GetCurrent();
	$Admin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
	return $admin
}