<#
.SYNOPSIS
A PowerShell script to switch between light and dark mode in Windows.

.DESCRIPTION
This script allows the user to switch between light and dark mode in Windows by setting the DarkMode parameter to 0 or 1 respectively. If executed without parameters, it will toggle between light and dark mode.

.PARAMETER DarkMode
An integer parameter that controls the dark mode setting. The default value is -1. Set to 0 to enable light mode and 1 to enable dark mode.

.EXAMPLE
.\win11darklightmode.ps1 -DarkMode 0
Enables light mode in Windows.

.EXAMPLE
.\win11darklightmode.ps1 -DarkMode 1
Enables dark mode in Windows.

.EXAMPLE - Direct execution via Explorer right click
.\win11darklightmode.ps1
The function automatically checks if Windows 11 is currently in Dark Mode and switches to Light Mode accordingly. It also verifies if Windows 11 is in Dark Mode and then switches to Light Mode.
#>

[CmdletBinding()]
param(
  [switch]$AutoDetect,
  [int]$DarkMode = -1
)

# Define the light and dark mode times
$LightModeTime = (Get-Date).Date.AddHours(8)
$DarkModeTime = (Get-Date).Date.AddHours(18)

# Get the current time
$currentTime = Get-Date

if ($AutoDetect) {

  # Check the current time and set the variable accordingly
  if ($currentTime -ge $LightModeTime -and $currentTime -lt $DarkModeTime) {
    $DarkMode = 0
    Write-Output "Automatically switching to Light Mode as the current time is within the predefined Light Mode hours."
  } else {
    $DarkMode = 1
    Write-Output "Automatically switching to Dark Mode as the current time is within the predefined Dark Mode hours."
  }  
}

if ($DarkMode -eq -1) {
  # Toggle between light and dark mode if executed without parameters
  $currentTheme = Get-ItemPropertyValue `
    -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize `
    -Name AppsUseLightTheme
  if ($currentTheme -eq 1) {
    $DarkMode = 1
  } else {
    $DarkMode = 0
  }
}

switch ($DarkMode) {
  0 {
    # Handle DarkMode = 0 case
    Write-Output "Light mode is enabling..."
    Set-ItemProperty `
      -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize `
      -Name AppsUseLightTheme `
      -Value 1
    Set-ItemProperty `
      -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize `
      -Name SystemUsesLightTheme `
      -Value 1
    Write-Output "Please wait while Windows Explorer restarts..."
    Stop-Process -Name explorer
  }
  1 {
    # Handle DarkMode = 1 case
    Write-Output "Dark mode is enabling..."
    Set-ItemProperty `
      -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize `
      -Name AppsUseLightTheme `
      -Value 0
    Set-ItemProperty `
      -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize `
      -Name SystemUsesLightTheme `
      -Value 0
    Write-Output "Please wait while Windows Explorer restarts..."
    Stop-Process -Name explorer
  }
  default {
    # Handle any other cases (the message below will not be shown since simple execution with auto swtich for dark to light and vice versa)
    Write-Warning "If you do not provide a parameter - it will auto switch from Dark to Light and vice versa"
    Write-Output "-DarkMode 0 - Change Windows Theme to Light mode"
    Write-Output "-Darkmode 1 - Change Windows Theme to Dark mode"
  }
}

# Get the command name
$CommandName = $PSCmdlet.MyInvocation.InvocationName;

# Get the list of parameters for the command
# $ParameterList = (Get-Command -Name $CommandName).Parameters;