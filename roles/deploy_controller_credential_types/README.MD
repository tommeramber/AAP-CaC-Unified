# In playbook for the ssh key integration into the job:
```yaml
- name: "Materizalize Vault SSH Key from Env Var"
  copy:
    content: "{{ lookup('env', 'MY_VAULT_SSH_KEY')}}"
    dest: "{{ ansible_ssh_private_key_file }}"
    mode: "0600"
  delegate_to: localhost
  no_log: true
  when: lookup('env', 'MY_VAULT_SSH_KEY') != ""]
```