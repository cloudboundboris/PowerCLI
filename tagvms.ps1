$categoryName = "<tag category in your vsphere>" 
$tagName = "<tag name>"

# Get the tag and category objects
$category = Get-TagCategory -Name $categoryName
$tag = Get-Tag -Name $tagName -Category $category

# Get the list of VMs 
$vms = Get-VM -Name "*<vm name(s)>*"
$total = $vms.Count
$counter = 0

foreach ($vm in $vms) {
    # Update progress bar each iteration
    $percent = [math]::Round(($counter / $total) * 100)
    Write-Progress -Activity "Assigning tag '$tagName' to VMs" `
                   -Status "Processing $($vm.Name) ($counter of $total)" `
                   -PercentComplete $percent

    # Remove tags from the same category
    $existingTags = Get-TagAssignment -Entity $vm | Where-Object {
        $_.Tag.Category.Id -eq $category.Id
    }

    foreach ($tagAssignment in $existingTags) {
        Remove-TagAssignment -TagAssignment $tagAssignment -Confirm:$false
    }

    # Assign the desired tag
    New-TagAssignment -Entity $vm -Tag $tag

    $counter++
}

# Final update to complete the bar
Write-Progress -Activity "Assigning tag '$tagName' to VMs" `
               -Status "Done" -Completed
Write-Host "All Done..."
