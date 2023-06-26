# Repository for Win11DarkLightMode PowerShell script #

This repository contains a PowerShell script that I made to help me switch between dark mode and light mode on a Windows 10/11 computer. Other scripts that were available on the internet did not switch properly. I hope this helps you as much as it helps me.

### SYNOPSIS
A PowerShell script to switch between light and dark mode in Windows.

### DESCRIPTION
This script allows the user to switch between light and dark mode in Windows by setting the DarkMode parameter to 0 or 1 respectively.

### PARAMETER DarkMode
An integer parameter that controls the dark mode setting. The default value is -1. Set to 0 to enable light mode and 1 to enable dark mode.

### EXAMPLE 1 - Enables light mode in Windows.

.\win11darklightmode.ps1 -DarkMode 0

### EXAMPLE 2 - Enables dark mode in Windows.

.\win11darklightmode.ps1 -DarkMode 1

### AUTOMATICLY SWITCHING MODES

You can automatically switch modes by adding this to your task scheduler.