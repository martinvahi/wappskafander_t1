#!/bin/bash
#==========================================================================

#WAPPSKAFANDER_T1_EXECUTION_PLATFORM="is_missing_for_the_given_platform"

#--------------------------------------------------------------------------
fun_wappskafander_t1_port_selection_semiverification() {
    local S_0=`uname `
    local S_WAPPSKAFANDER_T1_SUSPECTED_PLATFORM="detection_failed"
    #----------------------------------
    local S_1a="linux"
    local S_2b=`echo $S_0 | grep -i $S_1a - `;
    local S_2c=`expr length "$S_2b"`
    if  [ 1 -le $S_2c ]; then
        local S_WAPPSKAFANDER_T1_SUSPECTED_PLATFORM="$S_1a"
    fi
    #----------------------------------
    local S_1a="cygwin"
    local S_2b="`echo $S_0 | grep -i $S_1a - `";
    local S_2c=`expr length "$S_2b"`
    if  [ 1 -le $S_2c ]; then
        local S_WAPPSKAFANDER_T1_SUSPECTED_PLATFORM="$S_1a"
    fi
    #----------------------------------
    local S_3a="`echo $WAPPSKAFANDER_T1_EXECUTION_PLATFORM | grep -i $S_WAPPSKAFANDER_T1_SUSPECTED_PLATFORM - `";
    local S_3b=`expr length "$S_3a"`
    if  [ $S_3b -le 1 ]; then
        echo ""
        echo "wappskafander_t1 script selfcheck suspects that "
        echo "there is a mismatch between script platform type "
        echo "and the platform (Linux,Windows,etc.)."
        echo ""
        echo "Exiting."
        echo ""
        echo ""
    #    exit
    fi
}

#--------------------------------------------------------------------------
# The FreeBSD and other BSD-s are not 
# yet supported, because they do not have
# Bash as their default shell script.
fun_wappskafander_t1_port_selection_semiverification


#==========================================================================

