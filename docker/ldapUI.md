# MSSQL
### Pull and Run container
```
podman pull dnknth/ldap-ui
podman run -d --name ldapui \
-p 5000:5000 \
-e LDAP_URL=ldapi:/// \
-e "BASE_DN=dc=secldap,dc=com" \
-e "LOGIN_ATTR=cn=admin,dc=secldap,dc=com" \
-e USE_TLS=False \
-e INSECURE_TLS=False \
dnknth/ldap-ui
```

### Attach to container
```
podman exec -it ldapui bash
```

### Remove container
```
podman stop ldapui
podman rm ldapui
```

### Source
[https://hub.docker.com/r/dnknth/ldap-ui](https://hub.docker.com/r/dnknth/ldap-ui)  