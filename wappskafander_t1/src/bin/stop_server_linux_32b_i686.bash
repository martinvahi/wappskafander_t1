#!/bin/bash
#==========================================================================

S_PARENT_FOLDER_OF_START_BASH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$S_PARENT_FOLDER_OF_START_BASH/../bonnet/startup_script_complements/linux_32b_i686_common.bash"
echo ""
#-----------------------------------------

cd $JETTY_HOME/bin
jetty.sh stop

#==========================================================================

