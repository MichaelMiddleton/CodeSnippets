Function Get-SystemInformation
{
    param(
        [Parameter(Mandatory = $true)][String]$ComputerName
    )

    $OS = Get-CimInstance Win32_OperatingSystem
    $BIOS = Get-CimInstance Win32_Bios
    $CS = Get-CimInstance Win32_ComputerSystem
    $Proc = Get-CimInstance Win32_Processor
    
    $fix = Get-CimInstance Win32_QuickFixEngineering 

    # Get all local drives
    $drives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

    $Properties = New-Object psobject -Property @{
    
        "OSName" = $OS.Caption
        "ServicePack" = $OS.CSDVersion
        "SerialNumber" = $BIOS.SerialNumber
        "Manufacturer" = $BIOS.Manufacturer
        "NumberOfProcessors" = $Proc.Count
        "Processor" = $Proc[0].Name
        "InstalledMemory" = [math]::Round(($cs.TotalPhysicalMemory / 1GB))
        "BootUpState" = $CS.BootupState
        "Domain" = $CS.Domain
        "Manufacture" = $CS.Manufacturer
        "Model" = $CS.Model
        "ComputerName" = $CS.Name
        "HotFixes" = $fix
        "Drives" = $Drives


    }

    $Properties
}
Get-SystemInformation -ComputerName localhost

Get-CimInstance Win32_OperatingSystem | Select Caption, InstalledDate, ServicePackMajorVersion,OSArchitecture, BootDevice,  BuildNumber, CSName | FL