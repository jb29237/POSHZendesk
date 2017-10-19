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
function Suspend-ZendeskUser
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    Param
    (
        # Username for authentication
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [String]$Username,

        # API Token for authentication
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=1)]
        [String]$Token,

        # Zendesk root URL (eg. http://domain.zendesk.com)
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=2)]
        [String]$URL,

        # User ID
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=4)]
        [String]$ID


    )

    $tickets = [ordered]@{
        user = [ordered]@{
            suspended = "true";
            }
        }        

    $json = $tickets | ConvertTo-Json -Depth 10 -Compress

    Write-Verbose $json

    $endpoint = "/api/v2/users/$ID.json"

    $auth = Invoke-ZendeskPut -URL ($URL + $endpoint) -Username $Username -Token $Token
    
    Invoke-Restmethod -Uri $auth.Uri -Method $auth.Method -Headers $auth.Headers -Body $json -ContentType "application/json" 
}