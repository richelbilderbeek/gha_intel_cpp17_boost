#!/bin/bash
#
# squeue for as Richel
#
# Usage:
#
#   ./squeue_richel.sh
#
# No need to sbatch this script.
#

if [[ ! -z "${CLUSTER}" ]]; then
  echo "Working on a cluster"
else
  echo "Not working on a cluster, stopping"
  exit 42
fi

echo "Press CTRL-C to stop"

while true; do
  squeue -M snowy -u $USER
  sleep 1
done