[CmdletBinding()]
param (
    [int] $DarkMode = 1
)

switch ($DarkMode) {
    0 {
        # Handle DarkMode = 0 case
        Write-Output "Light mode is enabling..."
    }
    1 {
        # Handle DarkMode = 1 case
        Write-Output "Dark mode is enabling..."
    }
    default {
        # Handle any other cases (shouldn't happen if the parameter validation is working correctly)
        Write-Warning "Invalid value for DarkMode parameter. Valid values are 0 or 1."
    }
}

#Get the command name
$CommandName = $PSCmdlet.MyInvocation.InvocationName;

#Get the list of parameters for the command
$ParameterList = (Get-Command -Name $CommandName).Parameters;
