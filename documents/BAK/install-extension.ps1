Write-Host "`n"
Write-Host " ____________________________________________________________________________ " -ForegroundColor Red 
Write-Host "|                                                                            |" -ForegroundColor Red 
Write-Host "|    "  -ForegroundColor Red -NoNewline; Write-Host "                  " -ForegroundColor Green -NoNewline; Write-Host "                                                      |" -ForegroundColor Red    
Write-Host "|  "  -ForegroundColor Red -NoNewline; Write-Host "          __    __     ______     _____     ______     ______            " -ForegroundColor Green -NoNewline; Write-Host " |" -ForegroundColor Red  
Write-Host "|  "  -ForegroundColor Red -NoNewline; Write-Host "         /\ '-./  \   /\  ___\   /\  __-.  /\  ___\   /\  __ \           " -ForegroundColor Green -NoNewline; Write-Host " |" -ForegroundColor Red  
Write-Host "|  "  -ForegroundColor Red -NoNewline; Write-Host "         \ \ \-./\ \  \ \  __\   \ \ \/\ \ \ \  __\   \ \ \/\ \          " -ForegroundColor Green -NoNewline; Write-Host " |" -ForegroundColor Red  
Write-Host "|  "  -ForegroundColor Red -NoNewline; Write-Host "          \ \_\ \ \_\  \ \_____\  \ \____-  \ \_____\  \ \_____\         " -ForegroundColor Green -NoNewline; Write-Host " |" -ForegroundColor Red  
Write-Host "|  "  -ForegroundColor Red -NoNewline; Write-Host "           \/_/  \/_/   \/_____/   \/____/   \/_____/   \/_____/         " -ForegroundColor Green -NoNewline; Write-Host " |" -ForegroundColor Red  
Write-Host "|                                                                            |" -ForegroundColor Red 
Write-Host "|                                 Version 2022.0                             |" -ForegroundColor Red 
Write-Host "|                             contact@medeo-health.com                       |" -ForegroundColor Red 
Write-Host "|____________________________________________________________________________|" -ForegroundColor Red 
Write-Host "|                                                                            |" -ForegroundColor Red 
Write-Host "|                                   Created by                               |" -ForegroundColor Red 
Write-Host "|                                     Medeo                                  |" -ForegroundColor Red 
Write-Host "|____________________________________________________________________________|" -ForegroundColor Red 


#Install Kligo Chrome extension
 $regLocation = 'Software\Policies\Google\Chrome\ExtensionInstallForcelist'
        # Each extension if you want to force install more than 1 extension needs its own key #

        If (!(Test-Path "HKLM:\$regLocation")) {
            Write-Verbose -Message "No Registry Path, setting count to: 0"
            [int]$Count = 0
            Write-Verbose -Message "Count is now $Count" 
            New-Item -Path "HKLM:\$regLocation" -Force
        
        }
        
        Else {
            Write-Verbose -Message "Keys found, counting them..."
            [int]$Count = (Get-Item "HKLM:\$regLocation").Count
            Write-Verbose -Message "Count is now $Count"
        }

        
        $regKey = $Count + 1
        Write-Verbose -Message "Creating reg key with value $regKey"
        
        $regData = "ilbdbafpgbnlnmlpojeaiedhocikipjm;https://clients2.google.com/service/update2/crx"
        New-ItemProperty -Path "HKLM:\$regLocation" -Name $regKey -Value $regData -PropertyType STRING -Force
