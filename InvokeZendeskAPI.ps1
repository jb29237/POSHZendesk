function InvokeZendeskGet($Endpoint)
{
    Begin
    {
        $params = 
        @{
            Uri = "$URL$Endpoint";
            Method = 'GET';
            Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Username):$($Token)"));}
        } 
        
    }
    Process
    {
        $Output = Invoke-RestMethod -Uri $params.Uri -Method $params.Method -Headers $params.Headers -ContentType "application/json"
    }
    End
    {
        $Output.tags
    }

}