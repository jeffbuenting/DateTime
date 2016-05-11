Function Convert-DateFromUnix {

<#
    .SYnopsis
        Converts Unix DateTime to Powershell DateTime

    .Description
        Converts Unix (Epoch) date time to powershell Date Time.

    .links
        http://www.epochconverter.com/

    .Links
        https://nzfoo.wordpress.com/2014/01/21/converting-from-unix-timestamp/
#>

    [CmdletBinding()]
    Param (
        [Parameter(ParameterSetName='DateTime',Mandatory=$True,ValueFromPipeline=$True)]
        [String[]]$DateTime,
        
        [Parameter(ParameterSetName='Date')] 
        [String]$Date,

        [Parameter(ParameterSetName='Date')] 
        [String]$Time
    )

    Process {
        Switch ( $PSCmdlet.ParameterSetName ) {
            'DateTime' {
                Write-Verbose 'DateTime Parameter Set'

                Foreach ( $D in $DateTime ) {
                    Write-Verbose "Converting $D"
                    write-Output ([timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($D)))
                }
            }

            'Date' {
                Write-Verbose 'Date Parameter Set'
               
                # ------ Return todays data if no date parameter was specified.
                 Write-Verbose "Converting $Date"
                if ( $Date ) {
                        $D = "{0:D}" -f ( [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($Date)) )
                    }
                    else {
                        $D = "{0:D}" -f ( Get-Date )
                }

                # ----- Return the time now if no time was specified
                Write-Verbose "Converting $Time"
                if ( $Time ) {
                        $T = "{0:T}" -f ( [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($Time)) )
                    }
                    else {
                        $T = "{0:T}" -f ( Get-Date )
                }
                Write-Output (Get-Date "$D $T")
            }
        }
    }
}

Convert-DateFromUnix -DateTime 1454944938 -Verbose

Convert-DateFromUnix -Date 1454944938 -Time 190800 -Verbose

