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
function New-ZendeskTicket
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
        
        # Type of ticket(problem,incident,question,task,etc)
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        [String]$Type,

        # Subject line for ticket
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=1)]
        [String]$Subject,

        # Set User role(end-user,agent,admin)
        [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=2)]
        [String]$Comment
        

    )

    $tickets = [ordered]@{
        ticket = [ordered]@{
            subject = $Subject;
            type = $Type;
            comment =[ordered]@{ 
                body = $Comment;
            }
        }        
    }

    $json = $tickets | ConvertTo-Json -Depth 10 -Compress

    Write-Verbose $json

    $endpoint = "/api/v2/tickets.json"

    $auth = Invoke-ZendeskPost -URL ($URL + $endpoint) -Username $Username -Token $Token
    
    Invoke-Restmethod -Uri $auth.Uri -Method $auth.Method -Headers $auth.Headers -Body $json -ContentType "application/json" 
}