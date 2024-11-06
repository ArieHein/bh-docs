function Test-Grammar {
<#
.SYNOPSIS
    Checks that grammar is correct.
.DESCRIPTION
    This function checks that grammar is correct.
    It uses the gramma cli to check spelling.
    https://caderek.github.io/gramma/
.PARAMETER Path
    The path to the folder containing the markdown file. Mandatory.
.PARAMETER file
    The markdown file to check. Mandatory.
.EXAMPLE
    Test-Spelling -Path "C:\path\to\folder" -file "file.md"
    This will check the spelling in the file.md file in the folder provided.
#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$file
    )
  
}