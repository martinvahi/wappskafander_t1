#!/bin/bash
#==========================================================================

source "$WAPPSKAFANDER_T1_HOME/src/bonnet/script_components/bl_execution_platform_check.bash"
source "$WAPPSKAFANDER_T1_HOME/src/etc/server_configuration.bash"

if [ "$WAPPSKAFANDER_T1_EXECUTION_PLATFORM" == "linux_ubuntu" ]; then
    #JAVA_HOME="`cd $WAPPSKAFANDER_T1_HOME/src/bonnet/lib/linux_64b_java_7_update_11/jdk7; pwd;`"
    JAVA_HOME="`cd $WAPPSKAFANDER_T1_HOME/src/bonnet/lib/linux_32b_java_7_update_11; pwd;`"
    export JAVA_HOME
else 
    echo ""
    echo "Platform \"$WAPPSKAFANDER_T1_EXECUTION_PLATFORM\" not yet supported."
    echo "Error Message GUID: 'a565793a-6782-4d71-a32b-401160912dd7'"
    echo ""
    exit
fi
export JAVA="$JAVA_HOME/bin/java"
PATH="$JAVA_HOME/bin:$PATH"

if [ "$S_USE_BUNDLED_RUBY_DISTRIBUTION" == "YES" ]; then
    echo ""
    echo "The server administration scripts use bundled ruby distribution."
    if [ "$WAPPSKAFANDER_T1_EXECUTION_PLATFORM" == "linux_ubuntu" ]; then
        RUBY_HOME="$WAPPSKAFANDER_T1_HOME/src/bonnet/lib/ruby_v_1_9_3_linux_32b_i686"
    else 
        echo ""
        echo "Platform \"$WAPPSKAFANDER_T1_EXECUTION_PLATFORM\" not yet supported."
        echo "Error Message GUID: 'c533793a-67e2-4d71-a32b-401160912dd7'"
        echo ""
        exit
    fi
    GEM_HOME="$RUBY_HOME/gem_home"
    export GEM_HOME
    export RUBY_HOME
    PATH="$RUBY_HOME/bin:$PATH"
else
    echo ""
    echo "The server administration scripts use system ruby distribution."
fi

export JETTY_USER="`whoami`"
export JETTY_HOME="$WAPPSKAFANDER_T1_HOME/src/bonnet/jetty_8_1_8"
PATH="$JETTY_HOME/bin:$PATH"
export PATH
WAPPSKAFANDER_T1_FUNCSET_1_RB="$WAPPSKAFANDER_T1_HOME/src/bonnet/script_components/linux_32b_i686.rb"
WAPPSKAFANDER_T1_HOST_NAME="<currently not in use>" # $HOST_NAME"
WAPPSKAFANDER_T1_JETTY_PORT="$HTTP_PORT_NUMBER"
#-----------------------------------------
S_WAR_ORIGIN="$WAPPSKAFANDER_T1_HOME/src/servlet_project_in_maven_format/target"
S_JETTY_WEBAPPS="$JETTY_HOME/webapps"
export S_JETTY_WEBAPPS

#-----------------------------------------
S_TMP_1="$WAPPSKAFANDER_T1_HOME/src/bonnet/var/messaging"
mkdir -p $S_TMP_1
WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP="$S_TMP_1/message_stop_startup_t1.txt"
export WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP
chmod -f -R 0755 $WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP
rm -f $WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP

#-----------------------------------------

#==========================================================================

