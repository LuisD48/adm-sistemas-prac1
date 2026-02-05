Set-Content -Path "C:\tarea_diagnostico.ps1" -Value @"
Write-Host "=============================" -ForegroundColor Blue
Write-Host "  DIAGNOSTICO - SRV-WINDOWS  " -ForegroundColor Blue
Write-Host "=============================" -ForegroundColor Blue
Write-Host ""
Write-Host "HOSTNAME: $(hostname)"
Write-Host "IP INTERNA: $((Get-NetIPAddres -InterfaceAlias '*Ethernet 2*' -AddressFamily IPv4).IPAddress)"
Write-Host "Disco: $((Get-Volume C).SizeRemaining / 1GB) GB Libres"
Write-Host "=============================" -ForegroundColor Blue
pause
"@