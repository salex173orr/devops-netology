Vector-role
=========

This role can install Vector on Centos

Role Variables
--------------
| vars | description |
|----------|----------|
| vector_url   | URL for install Vector |

Example Playbook
----------------

    - hosts: vector
      roles:
         - { role: vector-role }

License
-------
MIT

Author Information
------------------
Alexandr Shtykov