# xdbcquery Commands

## Windows
### Local
```
xdbcquery /z /cacuxdbc04:system/manager/xvision:acuxdbc.cfg
```

### Remote
With DSN:  
```
xdbcquery /z /cacuxdbc11:system/manager/myDSN
```

Without DSN:  
```
xdbcquery /z /cacuxdbc03:system/manager/xvision:acuxdbc.cfg@port:IPorHostname!acuxdbc04
```

## Linux
### Local
```
xdbcquery /z /cacuxdbc04:system/manager/xvision:acuxdbc.cfg
```

### Remote
No DSN:  
```
xdbcquery /z /cacuxdbc03:system/manager/xvision:acuxdbc.cfg@port:IPorHostname\!acuxdbc04
```