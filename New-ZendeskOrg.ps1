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
function New-ZendeskOrg
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
        
        # User's email address
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [String]$Details,

        # User's First and Last name
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=1)]
        [String]$Name

    )

    $organizations = [ordered]@{
        organization = [ordered]@{
            name = $Name;
            details = $Details;
        }        
    }

    $json = $organizations | ConvertTo-Json -Depth 10 -Compress

    Write-Verbose $json

    $endpoint = "/api/v2/organizations.json"

    $auth = Invoke-ZendeskPost -URL ($URL + $endpoint) -Username $Username -Token $Token
    
    Invoke-Restmethod -Uri $auth.Uri -Method $auth.Method -Headers $auth.Headers -Body $json -ContentType "application/json" 
}