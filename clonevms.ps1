$SourceFolder = Get-Folder -Name "CHILD-FOLDER" -Location (Get-Folder -Name "TOP-FOLDER")
$DestinationFolder = Get-Folder -Name "CHILD-FOLDER" -Location (Get-Folder -Name "TOP-FOLDER")
$Datastore = "DataStoreName"
$Cluster = "ClusterName"
$ResourcePool = Get-Cluster -Name $Cluster | Get-ResourcePool
$SourceVMNames = @(
    "VMMACHINE-01",
   	"VMMACHINE-02",
  	"VMMACHINE-03",
    "VMMACHINE-04",
    "VMMACHINE-05"
)

$TargetVMNames = @(
    "VMMACHINE-01",
  	"VMMACHINE-02",
  	"VMMACHINE-03",
    "VMMACHINE-04",
    "VMMACHINE-05"
	
)


$Tasks = for ($i = 0; $i -lt $TargetVMNames.Count; $i++) {
    $SourceVMName = $SourceVMNames[$i]
    $TargetVMName = $TargetVMNames[$i]

    # Get the source VM object
    $SourceVM = Get-VM -Name $SourceVMName -Location $SourceFolder
    Write-Host "Cloning '$SourceVMName' to '$TargetVMName'..."

    New-VM -Name $TargetVMName -VM $SourceVM -ResourcePool $ResourcePool -Datastore $Datastore -Location $DestinationFolder -DiskStorageFormat Thin -RunAsync

}

$Tasks | Wait-Task

Write-Host "All clones completed successfully!"

