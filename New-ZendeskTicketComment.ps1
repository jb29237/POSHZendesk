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
function New-ZendeskTicketComment
{
    [CmdletBinding(SupportsShouldProcess=$true)]
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
        
        # Ticket status (open, solved, hold etc)
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=3)]
        [ValidateSet("New", "Open", "Pending", "Hold", "Solved", "Closed")]
        [String]$Status,

        # Ticket ID number
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=4)]
        [String]$ID,

        # Comment string to be posted
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=5)]
        [String]$Comment,
        
        # Public or private comment
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=6)]
        [Boolean]$Public = $True


    )

    $tickets = [ordered]@{
        ticket = [ordered]@{
            status = $Status;
            comment =[ordered]@{ 
                body = $Comment;
                public = $Public;
            }
        }        
    }

    $json = $tickets | ConvertTo-Json -Depth 10 -Compress

    Write-Verbose $json

    $endpoint = "/api/v2/tickets/$ID.json"

    $auth = Invoke-ZendeskPut -URL ($URL + $endpoint) -Username $Username -Token $Token
    
    Invoke-Restmethod -Uri $auth.Uri -Method $auth.Method -Headers $auth.Headers -Body $json -ContentType "application/json" 
}