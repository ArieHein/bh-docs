function Test-Spelling {
<#
.SYNOPSIS
    Checks that spelling is correct.
.DESCRIPTION
    This function checks that spelling is correct.
    It uses the cspell cli to check spelling.
    https://streetsidesoftware.com/vscode-spell-checker/
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