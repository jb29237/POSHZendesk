<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-ZendeskUser
{
    [CmdletBinding()]
    Param
    (
        # Username for authentication
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [String]$Username,

        # API Token for authentication
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        [String]$Token,

        # Zendesk root URL (eg. http://domain.zendesk.com)
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        [String]$URL
        
        

    )

    Begin
    {
        $params = @{
            Uri = "$URL/api/v2/users.json?per_page=100";
            Method = 'GET';
            Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Username):$($Token)"));} 
        }

        $FinalOutput = @()


    }

    Process
    {
        
        #$GetRest = Invoke-Restmethod -Uri $params.Uri -Method $params.Method -Headers $params.Headers -ContentType "application/json"
        #$URLpage = $($GetRest.next_page)
        
        #Write-Verbose = $URLpage
        
        If ($params)
        {
            $params = @{
                Uri = "$URL/api/v2/users.json?per_page=100";
                Method = 'GET';
                Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Username):$($Token)"));} 
            }
                
                While($params.Uri -notcontains $null)
                {
                    $Output2 = Invoke-Restmethod -Uri $params.Uri -Method $params.Method -Headers $params.Headers -ContentType "application/json"
                    Write-Verbose "$($params.uri)"
                    Write-Verbose "$($Output2.next_page)"
                    $params.Uri = $Output2.next_page 
                    start-Sleep -Seconds 2
                    $Output2.users
                    #Write-Verbose "$($params.uri)"
                }        
        }
        

    }

    End
    {

              

    }
}

