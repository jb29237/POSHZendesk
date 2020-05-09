function Invoke-ZendeskPut
{
    PARAM(
        [string]$URL,
        [string]$Username,
        [string]$Token
    )
          
    [pscustomobject]$auth = @{
        Uri = "$URL";
        Method = 'PUT';
        Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Username):$($Token)"));}
    } 
   
    $auth
   
}
