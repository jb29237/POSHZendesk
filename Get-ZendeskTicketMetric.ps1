<#
.Synopsis
   Returns ticket metrics data.
.DESCRIPTION
   Long description
.EXAMPLE
   Get-ZendeskTicketMetric -Username "info@example.com/token" -Token "64hj2824dshdlhnsdin090" -URL "https://testinstance.zendesk.com"

   url                              : https://testinstance.zendesk.com/api/v2/ticket_metrics/
                                      744.json
   id                               : 1740310744
   ticket_id                        : 1
   created_at                       : 2017-07-31T10:01:15Z
   updated_at                       : 2017-07-31T10:01:15Z
   group_stations                   : 1
   assignee_stations                : 1
   reopens                          : 0
   replies                          : 0
   assignee_updated_at              : 2017-07-31T10:01:15Z
   requester_updated_at             : 2017-07-31T10:01:15Z
   status_updated_at                : 2017-07-31T10:01:15Z
   initially_assigned_at            : 2017-07-31T10:01:15Z
   assigned_at                      : 2017-07-31T10:01:15Z
   solved_at                        : 
   latest_comment_added_at          : 2017-07-31T10:01:15Z
   reply_time_in_minutes            : @{calendar=; business=}
   first_resolution_time_in_minutes : @{calendar=; business=}
   full_resolution_time_in_minutes  : @{calendar=; business=}
   agent_wait_time_in_minutes       : @{calendar=; business=}
   requester_wait_time_in_minutes   : @{calendar=; business=}
   on_hold_time_in_minutes          : @{calendar=0; business=0}
#>

function Get-ZendeskTicketMetric
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
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

        $params = @{
            Uri = "$URL/api/v2/ticket_metrics.json";
            Method = 'GET';
            Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Username):$($Token)"));}
        } 
        $Output = Invoke-RestMethod -Uri $params.Uri -Method $params.Method -Headers $params.Headers -ContentType "application/json"

        $Output.ticket_metrics
}