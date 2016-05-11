@@setlocal
@@set POWERSHELL_BAT_ARGS=%*
@@if defined POWERSHELL_BAT_ARGS set POWERSHELL_BAT_ARGS=%POWERSHELL_BAT_ARGS:"=\"%
@@PowerShell -Command Invoke-Expression $('$args=@(^&{$args} %POWERSHELL_BAT_ARGS%);'+[String]::Join(';',$((Get-Content '%~f0') -notmatch '^^@@'))) & goto :EOF

Write-Host Hello from PowerShell!
Write-Host The passed arguments are: $args
