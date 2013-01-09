#!/bin/bash
#==========================================================================
S_FP_WD_HACK_1="`pwd`"

S_PARENT_FOLDER_OF_START_BASH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Hackedy Hack ,  /bonnet/bin_experimental
S_PARENT_FOLDER_OF_START_BASH="$S_PARENT_FOLDER_OF_START_BASH/../../bin" 

source "$S_PARENT_FOLDER_OF_START_BASH/../bonnet/startup_script_complements/linux_32b_i686_startup_fragment_1.bash"

cd $S_FP_WD_HACK_1

#==========================================================================

