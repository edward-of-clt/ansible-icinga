# Icinga Implementation with Ansible

## What these plays don't do

1. These do not install the Postgres or MySQL servers for you. The specification you identify is solely to determine what packages get installed.
2. They do not configure the Icinga web interface.
3. They do not import the IDO database into your specified database.

## Initial Installation

```shell
ansible-playbook -i <you/inv/file/here> [ --vault-password-file ~/.ssh/example.passwd ] [ -l icinga.example.com ] install.yml
```

## Configuration Upload

```shell
ansible-playbook -i <you/inv/files/here> [ --vault-password-file ~/.ssh/example.passwd ] write_configs.yml
```
