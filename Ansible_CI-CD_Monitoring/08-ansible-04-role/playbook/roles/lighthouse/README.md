Lighthouse-role
=========

This role installs and configures lighthouse

Role Variables
--------------
| Name                       | Default Value                           | Description                           |
|----------------------------|-----------------------------------------|---------------------------------------|
| lighthouse_location_dir    | /home/centos/lighthouse                 | directory for copy of lighthouse      |
| lighthouse_access_log_name | lighthouse_access                       | name for *.log file                   |
| nginx_user_name            | root                                    | user of nginx                         |
| lighthouse_vcs             | https://github.com/VKCOM/lighthouse.git | The git repo of lighthouse to install |


Dependencies
------------
 - nginx-role


Example Playbook
----------------

    - hosts: lighthouse
      roles:
         - { role: lighthouse-role }

License
-------

MIT

Author Information
------------------

Alexandr Shtykov
