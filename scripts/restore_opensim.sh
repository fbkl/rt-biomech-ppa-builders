#!/usr/bin/env sh

######################################################################
# @author      : frederico (frederico@asoldasme)
# @file        : restore_opensim
# @created     : lördag okt 18, 2025 18:18:17 CEST
#
# @description : 
######################################################################
DIR="src/opensim_core"

if pwd | grep -q "$DIR"; then
  echo "You are in a subfolder of $DIR."
  git reset --hard  
  ## TODO: I think this is on newer simbody, idk
  rm OpenSim/Simulation/Test/testExponentialContact.cpp
  rm OpenSim/Simulation/Model/ExponentialContactForce.*
  git apply ../../debian_folders/opensim_core/patches/*.patch
else
  echo "You are not in a subfolder of $DIR."
fi
exit

