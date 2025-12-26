# systemd Service Install

## Install Services
```
chmod +x /home/support/AcuSupport/AcuServices/*.sh
sudo ln -s /home/support/AcuSupport/AcuServices/*.service /etc/systemd/system/
sudo systemctl daemon-reload
```

## Start/Stop Service
```
sudo systemctl start serviceName
sudo systemctl stop serviceName
sudo systemctl restart serviceName
```