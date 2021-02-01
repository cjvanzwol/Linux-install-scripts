#! /bin/sh -e
systemctl start jupyterlab.service
systemctl  enable jupyterlab.service
exec xdg-open http://localhost:8888