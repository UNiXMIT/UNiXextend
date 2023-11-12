# OpenLDAP

### Pull and Run container
```
podman pull bitnami/openldap
podman run -dit --name openldap -e LDAP_ROOT=dc=secldap,dc=com -e LDAP_ADMIN_USERNAME=admin -e LDAP_ADMIN_PASSWORD=strongPassword -e LDAP_USERS=support -e LDAP_PASSWORDS=strongPassword -e LDAP_PORT_NUMBER=1389 -p 1389:1389 bitnami/openldap:latest
```

### Attach to container
```
podman exec -it openldap bash
```

### DN
```
dc=secldap,dc=com
cn=admin,dc=secldap,dc=com
cn=support,dc=secldap,dc=com
```

### Remove your container
```
podman stop openldap
podman rm openldap
```

### Source
https://bit.ly/42Xt3bE