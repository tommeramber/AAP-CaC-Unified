# AAP-CaC-Unified

## Required to do manualy before running the playbook
1. Create the following credentials:
  1. ansible controller creds for CaC
     * **Type**: Machine
     * **Username**: admin
     * **Password**: # the output of the following command: `oc get secret aap-controller-admin-password -n openshift-aap` (prod ocp)
  2. Ansible-Vault decryption for CaC GitOps # Saved in a safe
     * **Type**: Vault
     * **Vault Password**: # Saved in Safe
  2. GitLab
     * **Type**: Source Control
     * **Username**: # some applicative user generated for this
     * **SCM Private Key**: # SSH Key of root saved in a machine / safe
  3. registry
     * **Type**: Container Registry
     * **Username**: # some applicative user generated for this
     * **Password**: XXX
     * **Authentication URL**: <URL>
     
2. Create the following EE
   * **Name**: ee-supported-rhel9
   * **Image**: ee-supported-rhel9
   * **organization**: Default
   * **Registry Credential**: registry
   * **Pull**: always
     
3. Create the following Project
   * **Name**: GitLab
   * **organization**: Default
   * **Source Control Type**: Git
   * **Source Control URL**: ssh://...
   * **Source Control branch**: main
   * **Source Control crednetial**: `SCM: GitLab`
   * **Enabled options**: Update revision on job launch
   
4. Create the following JobTemplate
   * **Name**: CaC
   * **organization**: Default
   * **Job Type**: run
   * **Inventory**: Demo Inventory
   * **Project**: GitLab
   * **execution_environment**: ee-supported-rhel9
   * **Credentials**: `SSH: ansible controller creds for CaC` AND `Vault: Ansible-Vault decryption for CaC GitOps` ############ EDAAAAAAAAAAAAAA
   
5. LDAPS - from Medium

## Creds to populate in Job templates:
CaC - `AAP Controller ADMIN LOGIN`
CaC-EDA - `eda-creds-for-CaC` (env vars works seemlessly)

**Finaly - Run the job template and it will configure everything else**

## Dependencies
1. **`CaC` Job Template** must have: project `GitLab` and credentials `ansible controller creds for CaC` AND `Ansible-Vault decryption for CaC GitOps` and EE `ee-supported-rhel9` configured
2. **Project** must have: `GitLab` credential configured
3. **EE** must have: `registry` credential configured

# CaC-EDA
## Manual configuration before running the playbook
Run the CaC playbook and it will configure everything else , than run the CaC-EDA Playbook

## Rational - Vault Bridge
Since `EDA Controller` currently lacks the deep HashiCorp Vault integration that `AAP Controller` has, we're effectivly using the `AAP Controller` as a `"secure secrets proxy"` to fetch secrets from Vault and inject them during the CaC playbook run, that later injects them into the CaC-EDA configuration using the EDA custom credential that hold all the secrets relevant to EDA in a single creds type, which we attach to the CaC-EDA job template