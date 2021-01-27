#! /bin/sh -e
systemctl --user start jupyterlab.service
systemctl --user enable jupyterlab.service
if [ -d /opt/google/cros-containers ]
then
    exec xdg-open http://penguin.linux.test:8888
else
    exec xdg-open http://127.0.0.1:8888
fi