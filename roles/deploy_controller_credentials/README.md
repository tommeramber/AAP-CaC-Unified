# About saved Credentials in Hashi Vault vs. No Vault in organization

## If no Hashi Vault is available in the organization - `Ansible-Vault`
1. Decide on a strong key
2. Encrypt the `credentials/vars/main.yaml` file with
   ```bash
   ansible-vault encrypt roles/deploy_controller_credentials/vars/main.yaml
   ```
3. For editing the file
   ```bash
   ansible-vault edit roles/deploy_controller_credentials/vars/main.yaml
   ```
4. Save the ansible-vault key in: AAP controller as Vault credential + add it to the job template of CaC/deploy_main.yaml
5. Save the ansible-vault key in an organizational safe with access to AAP admins team only