## Terraform Module: vm_cluster_storage

Das Modul fügt Shared-Storage zu allen Cluster-Nodes hinzu. Hierzu wird ein Fileshare auf einem Azure Storage angelegt. 
Wenn kein Daten für einen bestehenden Storage Accoujnt angegeben werden, wird in der Ressourcegruppe des Clusters ein neuer Account angelegt und die Accountdaten als Output des Moduls zurückgegeben.

### Variablen

- deployment_region - (optional) Azure Region zum anlegen der Ressource (default: "West Europe")
- deployment_cluster_name - (Required) Name des Clusters
- deployment_rg_name - (Required) Name der Ressourcegruppe, in der ein neuer Storage Account angelegt werden soll
    
- os_admin_username - (Required) Benutzername des Admin-Benutzers zum Login in die Nodes
- os_admin_password - (Required) Passwort des Admin-Benutzers

- cluster_node_ids - (Required) Liste der VM ID´s der Nodes
- cluster_node_public_ips - (Required) Liste der öffentlichen IP-Adressen der Nodes
- cluster_node_count - (Optional) Anzahl der Nodes im Cluster (Default: 1)

- storage_share - (Optional) Name der Dateifreigabe (Default: "clusterdata" )
- storage_account - (Optional) Name des Storage-Accounts, auf dem die Dateifreigabe angelegt werden soll.^
- storage_key - (Optional) Zugriffsschlüssel für vorhandenen Storage-Account (Default: "")

### Output

- share - Name der Dateifreigabe für den Shared-Storage
- account - Name des Storage-Accounts, auf dem die Dateifreigabe erstellt wurde
- key - Zugriffsschlüssel für den Storage-Account