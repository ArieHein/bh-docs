function Get-ImageLinks {
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

# Create a function that goes over all the markdown files in a folder
# for each file, it uses the Test-Images function to verify the images exist and in the correct path.
# then it will calculate which images in the assets folder are not used in any of the markdown files
# and report of any unused images. It will allow the user to also delete the unused images.

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