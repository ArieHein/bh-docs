function Get-ImageLinks {
<#
.SYNOPSIS
    Check image links availability in the assets folder.
.DESCRIPTION
    This function reads a markdown file and extracts image links from it.
    It then checks if the images are available in the assets folder.
    If the images are not found, the function outputs a message.
.PARAMETER Path
    The path to the folder containing the markdown file and the assets folder. Mandatory.
.PARAMETER File
    The name of the markdown file to check for image links. Mandatory.
.EXAMPLE
    Get-ImageLinks -Path "C:\code\bh-docs\bh-docs\tests" -File "doc1.md"
    This example reads the "doc1.md" file in the "C:\code\bh-docs\bh-docs\tests" folder and checks for image links.
#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$File
    )

    # Check that the path exists
    if (-not (Test-Path -Path $Path)) {
        $Message = "Path does not exist."
        if($PSCmdlet.MyInvocation.BoundParameters['Verbose']) {
           $Message += " Path provided: $path"
        }
        Write-Output $Message
        return
    }

    $FullPath = Join-Path -Path $Path -ChildPath $File

    # Check that the file exists
    if (-not (Test-Path -Path $FullPath)) {
        $Message = "File does not exist."
        if($PSCmdlet.MyInvocation.BoundParameters['Verbose']) {
           $Message += " File provided: $File"
        }
        Write-Output $Message
        return
    }

    try {
        # Read the file
        $Content = Get-Content -Path $FullPath -Raw

        # Look for image links by searching for a regular expression that matches a pattern
        $Pattern = "!\[.*?\]\(([^)]+)\)"
        $ImageMatches = [regex]::Matches($Content, $Pattern)
    
        # If no image links are found, return message
        if ($ImageMatches.Count -eq 0) {
            $Message = "No image links were found in the file."
            if($PSCmdlet.MyInvocation.BoundParameters['Verbose']) {
               $Message += " Path provided: $Path. File provided: $File"
            }
            Write-Output $Message
            return
        }

        $imageLinks = @()
        foreach ($ImageMatch in $ImageMatches) {
            $ImagePath = $ImageMatch.Groups[1].Value
            $imageLinks += $ImagePath
        }

        # Output the extracted image paths
        foreach ($imageLink in $imageLinks) {
            Write-Output "Image link found: $imageLink"
        }
    }
    catch {
        Write-Error "An error occurred: $_"
    }
}

function Remove-UnusedImages {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $false)]
        [switch]$Force = $false
    )

    # Check that the path exists
    if (-not (Test-Path $Path)) {
        Write-Error "The path $Path does not exist"
        return
    }

    # Get all the markdown files
    $Files = Get-ChildItem -Path $Path -Filter *.md -Recurse

    # Go over each file
    foreach ($File in $Files) {

        $exist = $false

        $exist = Get-ImageLinks -Path $Path -File $File

        if ($exist) {
            Write-Host "All images in $File exist"
        } else {
            Write-Host "There are missing images in $File"
        }


        # For each image found in the correct path and name, remove it from the list of images
        # such that at the end of the loop, the list of images will include only the path and image names
        # that are not used in any of the markdown files
        # if the $force switch is provided, it will delete them, else just report them




    }

}


Get-ImageLinks -Path "C:\code\bh-docs\bh-docs\tests" -file "doc2.md"