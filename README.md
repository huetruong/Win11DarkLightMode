# Win11DarkLightMode

This repository contains a PowerShell script that allows users to switch 
between dark mode and light mode on a Windows 10/11 computer. 
Unlike other scripts available on the internet, this script ensures a proper
switch between modes. 

## win11darklightmode.ps1

### SYNOPSIS
A PowerShell script to switch between light and dark mode in Windows.

### DESCRIPTION
This script allows the user to switch between light and dark mode in 
Windows by setting the DarkMode parameter to 0 or 1 respectively.

### PARAMETER DarkMode
An integer parameter that controls the dark mode setting. 
The default value is -1. Set to 0 to enable light mode and 1 to enable dark mode.

### EXAMPLE 1 - Enables light mode in Windows.
.\win11darklightmode.ps1 -DarkMode 0

### EXAMPLE 2 - Enables dark mode in Windows.
.\win11darklightmode.ps1 -DarkMode 1

### EXAMPLE 3 - Direct execution via Explorer right click
.\win11darklightmode.ps1

The script automatically checks if Windows 11 is currently in Dark Mode and switches to Light Mode accordingly. It also verifies if Windows 11 is in Dark Mode and then switches to Light Mode.

### AUTOMATICLY SWITCHING MODES

You can automatically switch modes based on time of day by utilizing the config-taskscheduler.ps1 script. 

## config-taskscheduler.ps1

### SYNOPSIS
This script creates or removes two scheduled tasks that switch between light and dark mode on Windows 11 at specified times.

### DESCRIPTION
This script is used to create two scheduled tasks that switch between light and dark mode on Windows 11 at specified times.

**The script requires administrative priviledge, 
therefore, it checks if it is being run as an administrator and exits if it is not.**

The script takes three parameters: `LightModeTime`, `DarkModeTime`, and `Remove`.

 If the `LightModeTime` and `DarkModeTime` parameters are not specified, the script will prompt the user to enter them. 
 The script then creates two scheduled tasks using the specified times, one for switching to light mode and one for switching to dark mode.

If the `Remove` parameter is specified, the script will remove the scheduled tasks.

### PARAMETER LightModeTime
The time at which the light mode task should be triggered (e.g. "8am").

### PARAMETER DarkModeTime
The time at which the dark mode task should be triggered (e.g. "6pm").

### PARAMETER Remove
If specified, the script will remove the scheduled tasks.

### EXAMPLE

.\config-taskscheduler.ps1 -LightModeTime "8am" -DarkModeTime "6pm"

Creates two scheduled tasks that switch between light and dark mode on Windows 11 at 8am and 6pm respectively.

### EXAMPLE
.\config-taskscheduler.ps1 -Remove

Removes the two scheduled tasks created by this script.

## Compatibility

These scripts are compatible with Windows 10 and Windows 11.

## Note

Please note that these scripts require administrator privileges to run.