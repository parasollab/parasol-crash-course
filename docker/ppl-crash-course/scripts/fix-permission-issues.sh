#!/bin/bash

################################################################################

# Allow current host user to access files generated by Docker 'root' user.
chown -R ${HOST_UID}:${HOST_GID} /root/.ros/
chown -R ${HOST_UID}:${HOST_GID} /root/ppl_cc_ws/
