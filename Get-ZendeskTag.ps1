<#
.Synopsis
   Outputs a list of tags currently being used throughout Zendesk instance.
.DESCRIPTION
   Long description
.EXAMPLE
   Get-ZendeskTag -Username "info@example.com/token" -Token "64hj2824dshdlhnsdin090" -URL "https://testinstance.zendesk.com"

   name     count
   ----     -----
   option_1     1
   admin       10
   auth_serv    3
#>

function Get-ZendeskTag
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

   $endpoint = "/api/v2/tags.json"

    $auth = Invoke-ZendeskGet -URL ($URL + $endpoint) -Username $Username -Token $Token
   
    $Output = Invoke-Restmethod -Uri $auth.Uri -Method $auth.Method -Headers $auth.Headers -ContentType "application/json"

    $Output.tags
}