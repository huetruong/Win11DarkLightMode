<#
.SYNOPSIS
A PowerShell script to switch between light and dark mode in Windows.

.DESCRIPTION
This script allows the user to switch between light and dark mode in Windows by setting the DarkMode parameter to 0 or 1 respectively.

.PARAMETER DarkMode
An integer parameter that controls the dark mode setting. The default value is -1. Set to 0 to enable light mode and 1 to enable dark mode.

.EXAMPLE
.\win11darklightmode.ps1 -DarkMode 0
Enables light mode in Windows.

.EXAMPLE
.\win11darklightmode.ps1 -DarkMode 1
Enables dark mode in Windows.
#>

[CmdletBinding()]
param (
    [int] $DarkMode = -1
)

switch ($DarkMode) {
    0 {
        # Handle DarkMode = 0 case
        Write-Output "Light mode is enabling..."
        Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 1
        Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 1
        Write-Output "Please wait while Windows Explorer restarts..."
        Stop-Process -Name explorer
    }
    1 {
        # Handle DarkMode = 1 case
        Write-Output "Dark mode is enabling..."
        Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
        Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0
        Write-Output "Please wait while Windows Explorer restarts..."
        Stop-Process -Name explorer
    }
    default {
        # Handle any other cases (shouldn't happen if the parameter validation is working correctly)
        Write-Warning "Invalid value for DarkMode parameter. Valid values are 0 or 1."
        Write-Output "-DarkMode 0 - Change Windows Theme to Light mode"
        Write-Output "-Darkmode 1 - Change Windows Theme to Dark mode"
    }
    
}

#Get the command name
$CommandName = $PSCmdlet.MyInvocation.InvocationName;

#Get the list of parameters for the command
$ParameterList = (Get-Command -Name $CommandName).Parameters;