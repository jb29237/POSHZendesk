$functions  = Get-ChildItem -Path "$PSScriptRoot\*.ps1" -Recurse -ErrorAction SilentlyContinue
 
 #Dot source the files
   Foreach($import in $functions)
   {
       Try
       {
           . $import.fullname
           
       }
       Catch
       {
           Write-Error -Message "Failed to import function $($import.fullname): $_"
       }
   }