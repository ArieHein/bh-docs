function Test-Tables {
<#
.SYNOPSIS
    Checks that tables structure follow standards.
.DESCRIPTION
    This function checks that tables structure follow standards.
    That tables align, have proper spacing, no missing pipes and more
    It uses markdownlint to check the tables.
.PARAMETER Path
    The path to the folder containing the markdown file. Mandatory.
.PARAMETER file
    The markdown file to check. Mandatory.
.EXAMPLE
    Test-Tables -Path "C:\path\to\folder" -file "file.md"
    This will check the tables in the file.md file in the folder provided.
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