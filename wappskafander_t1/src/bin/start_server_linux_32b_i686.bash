#!/bin/bash
#==========================================================================

S_PARENT_FOLDER_OF_START_BASH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$S_PARENT_FOLDER_OF_START_BASH/../bonnet/startup_script_complements/linux_32b_i686_startup_fragment_1.bash"

cd $JETTY_HOME/bin


if [ ! -e $WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP ]; then
    jetty.sh start
else
    echo "Server startup sequence aborted."
    echo ""
    chmod -f 0755 $WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP 
    rm -f $WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP 
fi

#==========================================================================

