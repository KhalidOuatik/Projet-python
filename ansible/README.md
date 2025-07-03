# Ansible - Provisionnement

- `inventory.ini` : inventaire des hôtes (à adapter avec les IP réelles)
- `site.yml` : playbook principal (ajoute tes rôles/tâches ici)

Exemple de commande :
```bash
ansible-playbook -i inventory.ini site.yml
```
