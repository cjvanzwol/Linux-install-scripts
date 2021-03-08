#! /bin/sh -e
sudo systemctl start jupyterlab.service
sudo systemctl  enable jupyterlab.service
exec xdg-open http://localhost:8888