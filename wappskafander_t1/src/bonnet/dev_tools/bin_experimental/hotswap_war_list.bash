#!/bin/bash
#==========================================================================
WAPPSKAFANDER_T1_EXECUTION_PLATFORM="linux_ubuntu"
func_init_WAPPSKAFANDER_T1_HOME () {
    local S_FP_PWD="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    WAPPSKAFANDER_T1_HOME="`cd $S_FP_PWD/../../../../; pwd`" # bonnet/dev_tools/bin_experimental
    export WAPPSKAFANDER_T1_HOME
} 
func_init_WAPPSKAFANDER_T1_HOME 
source "$WAPPSKAFANDER_T1_HOME/src/bonnet/script_components/bl_init_environment_variables.bash"
#--------------------------------------------------------------------------
S_FP_WD_HACK_1="`pwd`"
# Hackedy Hack 
source "$WAPPSKAFANDER_T1_HOME/src/bonnet/script_components/bl_startup_part_x1.bash"
cd $S_FP_WD_HACK_1
#==========================================================================

