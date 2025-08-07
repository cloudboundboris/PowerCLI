## Clone VMs - clonevms.ps1

#####
This one clones multiple VMs async
Dont forget to replace CHILD-FOLDER, TOP-FOLDER, DataStoreName and ClusterName with your settings.
#####

---

## Tag VMs - tagvms.ps1

####
This script tags or re-tags VMs in vcenter. This scripts assumes the tags and categories are already existing. There is definitely a way to create tags and categories with PowerCLI as well. Thats not included in this script. The progress bar is for aesthetics, not a necessary component at all. 
As always dont forget to replace the following:
```PowerShell
$categoryName
$tagName
$vms
```
---
