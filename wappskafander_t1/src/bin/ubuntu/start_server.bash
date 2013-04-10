#!/bin/bash
#==========================================================================
WAPPSKAFANDER_T1_EXECUTION_PLATFORM="linux_ubuntu"
func_init_WAPPSKAFANDER_T1_HOME () {
    local S_FP_PWD="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    WAPPSKAFANDER_T1_HOME="`cd $S_FP_PWD/../../../; pwd`"
    export WAPPSKAFANDER_T1_HOME
} 
func_init_WAPPSKAFANDER_T1_HOME 
#--------------------------------------------------------------------------

S_ENTRYCMD="start_server";
source "$WAPPSKAFANDER_T1_HOME/src/bonnet/wappskafander_t1_core/script_components/bl_entrycmd_demultiplexer.bash"

#==========================================================================

