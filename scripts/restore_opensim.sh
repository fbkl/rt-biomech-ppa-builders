#!/usr/bin/env sh

######################################################################
# @author      : frederico (frederico@asoldasme)
# @file        : restore_opensim
# @created     : lördag okt 18, 2025 18:18:17 CEST
#
# @description : 
######################################################################

git checkout .  && git apply ../../debian_folders/opensim_core/patches/*.patch
rm OpenSim/Simulation/Model/ExponentialContactForce.*

