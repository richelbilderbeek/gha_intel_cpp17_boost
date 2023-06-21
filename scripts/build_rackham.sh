#!/bin/bash
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 10:00
#SBATCH --job-name gha_intel_cpp17
#SBATCH --qos=short
#
# Build the project on Rackham, an UPPMAX computer cluster, see
# https://www.uppmax.uu.se/support/user-guides/rackham-user-guide/
#
# Usage:
#
#   ./scripts/build_rackham.sh
#
#  Using sbatch, when being Richel:
#
#   sbatch -A uppmax2023-2-25 -M snowy scripts/build_rackham.sh
#
#  Or using the convenience script:
#
#   ./sbatch_richel.sh
#
if [[ ! -z "${CLUSTER}" ]]; then
  echo "Working on a cluster"
else
  echo "Not working on a cluster, stopping"
  exit 42
fi

date

# One needs a boost module that is compatible with an Intel module:
#
# module spider boost
#
# gives, among others:
# 
#        boost/1.70.0_intel18.3_intelmpi18.3
#        boost/1.70.0_intel18.3_mpi3.1.3
#        boost/1.70.0_intel18.3
#        boost/1.75.0-gcc9.3.0
#        boost/1.78.0_gcc11.2.0_mpi4.1.2
#        boost/1.78.0_gcc11.2.0
#        boost/1.79.0_gcc11.2.0_mpi4.1.2
#        boost/1.81.0-gcc10.3.0-mpi4.1.1
#        boost/1.81.0-gcc10.3.0


module load gcc/11.2.0 boost/1.78.0_gcc11.2.0 intel-oneapi compiler
icpx main.cpp -L/sw/libs/boost/1.78.0_gcc11.2.0/snowy/lib -lboost_graph -o gha_intel_cpp17_boost

# Use older Intel compiler
#module load intel/18.3 boost/1.70.0_intel18.3
# icpc main.cpp -L/sw/libs/boost/1.70.0_intel18.3/snowy/lib -lboost_graph -o gha_intel_cpp17_boost


./gha_intel_cpp17_boost
