function Invoke-ZendeskGet()
{
    PARAM(
        [string]$URL,
        [string]$Username,
        [string]$Token
    )
          
    [pscustomobject]$auth = @{
        Uri = "$URL";
        Method = 'GET';
        Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Username):$($Token)"));}
    } 
   
    $auth
   
}
