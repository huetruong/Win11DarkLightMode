<#
.SYNOPSIS
This script creates or removes two scheduled tasks that switch between
light and dark mode on Windows 11 at specified times.

.DESCRIPTION
This script, `config-taskscheduler.ps1`, is used to create two scheduled
tasks that switch between light and dark mode on Windows 11 at specified
times. The script takes three parameters: `Remove`, `LightModeTime`, and
`DarkModeTime`. If the `Remove` parameter is specified, the script will
remove the scheduled tasks. Otherwise, it will create them.

The script checks if it is being run as an administrator and exits if it is
not. If the `LightModeTime` and `DarkModeTime` parameters are not specified,
the script will prompt the user to enter them. The script then creates two
scheduled tasks using the specified times, one for switching to light mode
and one for switching to dark mode.

The script uses two variables: `pwshExec` and `workingDir`. The `pwshExec`
variable specifies the path to the PowerShell executable, while the
`workingDir` variable specifies the working directory for the scheduled tasks.

Before running the script, make sure to edit the value of the `pwshExec`
variable to match the location of the PowerShell executable on your system.
Also, make sure that the value of the `workingDir` variable is set to the
directory where the `win11darklightmode.ps1` script is located.

.PARAMETER Remove
If specified, the script will remove the scheduled tasks.

.PARAMETER LightModeTime
The time at which the light mode task should be triggered (e.g. "8am").

.PARAMETER DarkModeTime
The time at which the dark mode task should be triggered (e.g. "6pm").

.EXAMPLE
.\config-taskscheduler.ps1 -LightModeTime "8am" -DarkModeTime "6pm"
Creates two scheduled tasks that switch between light and dark mode on 
Windows 11 at 8am and 6pm respectively.

.EXAMPLE
.\config-taskscheduler.ps1 -Remove
Removes the two scheduled tasks created by this script.
#>

[CmdletBinding()]
param(
  [string]$Remove = "",
  [string]$LightModeTime,
  [string]$DarkModeTime
)

# Get the command name
$CommandName = $PSCmdlet.MyInvocation.InvocationName;

# Set variables for PowerShell executable path and working directory
$pwshExec = "C:\Program Files\PowerShell\7\pwsh.exe"
$workingDir = (Get-Location).path

# Set variables for task names
$taskLMName = "Switch to Light Mode"
$taskDMName = "Switch to Dark Mode"

# Check if the script is being run as an administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # If not, exit with an error message
    Write-Error "This script requires administrator priviledges to run."
    exit
}

# Check if Remove parameter is specified
if ($Remove -ne "") {
    # If yes, remove scheduled tasks

    Write-Output "Removing scheduled tasks..."
    Unregister-ScheduledTask -TaskName $taskLMName -ErrorAction SilentlyContinue -Confirm:$false
    Unregister-ScheduledTask -TaskName $taskDMName -ErrorAction SilentlyContinue -Confirm:$false

} else {
    # If no, create scheduled tasks

    # Prompt user for LightModeTime if not specified
    if (-not $LightModeTime) {
        do {
            $LightModeTime = Read-Host "Please enter the trigger time for the light mode task (e.g. 8am)"
            try {
                $time = [datetime]::ParseExact($LightModeTime,"htt",$null)
                $valid = $true
            } catch {
                Write-Warning "Invalid time format. Please try again."
                $valid = $false
            }
        } while (-not $valid)
    }

    # Prompt user for DarkModeTime if not specified
    if (-not $DarkModeTime) {
        do {
            $DarkModeTime = Read-Host "Please enter the trigger time for the dark mode task (e.g. 6pm)"
            try {
                $time = [datetime]::ParseExact($DarkModeTime,"htt",$null)
                $valid = $true
            } catch {
                Write-Warning "Invalid time format. Please try again."
                $valid = $false
            }
        } while (-not $valid)
    }

    # Create array of tasks
    $tasks = @(
        @{
            Name = $taskLMName
            Argument = "win11darklightmode.ps1 -DarkMode 0"
            TriggerTime = $LightModeTime
        },
        @{
            Name = $taskDMName
            Argument = "win11darklightmode.ps1 -DarkMode 1"
            TriggerTime = $DarkModeTime
        }
    )

    # Loop through tasks and create scheduled tasks
    foreach ($task in $tasks) {
        $stAction = New-ScheduledTaskAction -Execute $pwshExec `
           -Argument $task.Argument `
           -WorkingDirectory $workingDir
        $stTrigger = New-ScheduledTaskTrigger -Daily -At $task.TriggerTime
        Register-ScheduledTask $task.Name -Action $stAction -Trigger $stTrigger
    }
}