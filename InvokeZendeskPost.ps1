function Invoke-ZendeskPost()
{
    PARAM(
        [string]$URL,
        [string]$Username,
        [string]$Token
    )
          
    [pscustomobject]$auth = @{
        Uri = "$URL";
        Method = 'POST';
        Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Username):$($Token)"));}
    } 
   
    $auth
   
}
