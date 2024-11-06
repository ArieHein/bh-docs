function Test-MarkdownFile {
<#
.SYNOPSIS
    Checks that a file is indeed a markdown file.
.DESCRIPTION
    This function checks that a file is indeed a markdown file.
    It looks for markdown headers, lists, links, and code fences.
    This is best effort, as there can be a few false positives.
.PARAMETER filePath
    The path to the file to check. Mandatory.
.EXAMPLE
    Test-MarkdownFile -filePath "C:\path\to\file.md"
    This will check if the file provided is a markdown file.
#>
    [CmdletBinding()]
    param (
        [string]$filePath
    )

    if (-not (Test-Path $filePath)) {
        return $false
    }

    $fileExtension = [System.IO.Path]::GetExtension($filePath)
    if ($fileExtension -ne ".md") {
        return $false
    }

    $content = Get-Content $filePath -Raw

    # Check for markdown headers, lists, links, and code fences
    if ($content -match "^\s*#\s" -or # Header
        $content -match "^\s*[-*+]\s" -or # List
        $content -match "\[.*\]\(.*\)" -or # Link
        $content -match "^\s*```.*\n" -or # Code fence with language element
        ($content -match "```\s*$" -and $content -match "^\s*$")) { # End of code fence and empty line at end of file
        return $true
    }

    return $false
}
