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
function New-ZendeskUser
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
        [String]$Email,

        # User's First and Last name
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=1)]
        [String]$Name,

        # Set User role(end-user,agent,admin)
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=2)]
        [String]$Role = "end-user"
        

    )

    $users = [ordered]@{
        user = [ordered]@{
            name = $Name;
            email = $Email;
            role = $Role;
        }        
    }

    $usersjson = $users | ConvertTo-Json -Depth 10 -Compress

    Write-Verbose $usersjson

    $endpoint = "/api/v2/users.json"

    $auth = Invoke-ZendeskPost -URL ($URL + $endpoint) -Username $Username -Token $Token
    
    Invoke-Restmethod -Uri $auth.Uri -Method $auth.Method -Headers $auth.Headers -Body $usersjson -ContentType "application/json" 
}