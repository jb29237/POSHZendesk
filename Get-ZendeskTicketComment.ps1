<#
.Synopsis
   Outputs a list of comments based on ticket ID selected.
.DESCRIPTION
   Long description
.EXAMPLE
  input
.EXAMPLE
   Another example of how to use this cmdlet
#>

function Get-ZendeskTicketComment
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
        [String]$URL,

        # Zendesk root URL (eg. http://domain.zendesk.com)
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=2)]
        [String]$ID
   )

    $endpoint = "/api/v2/tickets/$ID/comments.json"

    $auth = Invoke-ZendeskGet -URL ($URL + $endpoint) -Username $Username -Token $Token
   
    $Output = Invoke-Restmethod -Uri $auth.Uri -Method $auth.Method -Headers $auth.Headers -ContentType "application/json"

    $Output.comments
}