<#
.Synopsis
   Outputs a list of tickets based on the staus selected.
.DESCRIPTION
   Long description
.EXAMPLE
   Get-ZendeskOpenTickets -Username "info@example.com/token" -Token "64hj2824dshdlhnsdin090" -URL "https://testinstance.zendesk.com"

   subject                                 priority created_at          
   -------                                 -------- ----------          
   Printer jam                             normal   2017-03-09T14:43:09Z
   Help my computer is broken!                      2017-03-08T14:39:55Z
   New computer required in HR             low      2017-03-08T14:18:57Z

.EXAMPLE
   Another example of how to use this cmdlet
#>

function Get-ZendeskTicket
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

        # Status of tickets (eg. open, pending, solved, closed, etc.)
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=3)]
        [ValidateSet("New", "Open", "Pending", "Hold", "Solved", "Closed")]
        [String]$Status = "Open"


   )

        $params = @{
            Uri = "$URL/api/v2/search.json?query=type:ticket status:$Status";
            Method = 'GET';
            Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Username):$($Token)"));} 
        } 
        $Output = Invoke-RestMethod -Uri $params.Uri -Method $params.Method -Headers $params.Headers -ContentType "application/json"

        $Output.results
}