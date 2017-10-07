<#
.Synopsis
   Initialize 
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Initialize-ZendeskConfiguration
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # The Zendesk URL
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$false,
                   Position=0)]
        [string]$URL,

       # Zendesk username/email address
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$false,
                   Position=1)]
        [string]$Username,

        # Zendesk API token
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$false,
                   Position=2)]
        [string]$APIToken,

        # Save this configuration to the config file
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$false,
                   Position=3)]
        [switch]$Save
    )

    # Set variables used throughout this script.
    $script:ConfigRoot = "$env:LOCALAPPDATA\POSHZendesk"
    $script:URL = $URL
    $script:Username = $Username
    $script:APIToken = $APIToken
    
    

    <# config file section - STILL WORKING ON
    # Check if the config root directory already exists. If not create it. 
    Write-Verbose "Checking configuration root directory exists"

    if(Test-Path -Path $ConfigRoot){
        Write-Verbose "Configuration root directory does exist"
    }

    else {
        Write-Verbose "Configuration root directory does not exist"
        Write-Verbose "Creating configuration root directory"
        
        New-Item -Path $ConfigRoot
    
        if(Test-Path -Path $ConfigRoot){
            Write-Verbose "Configuration root directory created successfully"
        }

        else {
            Write-Error "Failed to create configuration root directory - $ConfigRoot"
        }
    }

    #Create the configuration file. We'll overwrite the file if it already exists for now
    #>

}