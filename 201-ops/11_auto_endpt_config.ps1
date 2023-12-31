# Script Name:                  Automated Endpoint Configuration
# Author:                       Marcus Nogueira
# Date of latest revision:      11/06/2023
# Purpose:                      Automate Windows Endpoint

# Declaration of variables

# Declaration of functions


# Main

#Enable File and Printer Sharing
echo "Enabling File and Printer Sharing"
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True

#Allow ICMP traffic
#Reports OK
echo "Allowing ICMP Traffic"
netsh advfirewall firewall add rule name="Allow incoming ping requests IPv4" dir=in action=allow protocol=icmpv4 

#Enable Remote management
#Enable RDP connections and open the firewall
echo "Enabled RDP connections in Registry"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
echo "Opening Firewall for RDP"
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

#Enable Network Level Authentication, an added layer of security for RDP
echo "Enabled NLA for RDP connections"
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 1

#Remove Bloatware
echo "Running Bloatware remover"
iex ((New-Object System.Net.WebClient).DownloadString('https://git.io/debloat'))

#An attempt to run the non-GUI silent version of the Debloater failed testing on a new VM so we've returned to the GUI version.

#Enable HyperV without needing a reboot immediately after completion of the command.
echo "Enabling HyperV (Reboot will be necessary once script is complete.)"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart

#Disable SMBv1 
# This has no success message or visual acknowledgment
echo "Disabling SMBv1"
Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force

echo "Forcing a Reboot."
Restart-Computer -Force
# End
