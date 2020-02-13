function Get-Weather {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory = $False,
            ValueFromPipeline = $true,
            Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]$Location,
        [Switch]$OneLine,
        [Switch]$SmallView, #?n
        [Switch]$NoTitle, #?q
        [Switch]$DontShowLocation, #?Q
        [ValidateSet("m/s", "km/h")]
        [String]$WindSpeedMetric = "m/s", #?M
        [ValidateRange(0, 3)]
        [int]$DaystoForcast = 0 #?0-3
    )

    Begin {
        #Build Request from input
        $Request = "https://wttr.in/" + $Location
        if ($OneLine) {
            $Request += "?format=3"
        }
        else {
            if ($SmallView) {
                $Request += "?n"
            }
            if ($NoTitle -and !$DontShowLocation) {
                $Request += "?q"
            }
            if ($DontShowLocation) {
                $Request += "?Q"
            }
            if ($WindSpeedMetric -eq "m/s") {
                $Request += "?M"
            }
            $Request += "?$DaystoForcast"
        }
    }

    Process {
        Write-Verbose $Request
        $HTTPResponse = Invoke-WebRequest -Uri $Request
        $HTTPResponse.ParsedHtml.body.outerText
    }
    
}
