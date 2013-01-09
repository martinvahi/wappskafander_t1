#!/bin/bash
#==========================================================================

WAPPSKAFANDER_T1_HOME="$S_PARENT_FOLDER_OF_START_BASH/../"
export WAPPSKAFANDER_T1_HOME

source "$WAPPSKAFANDER_T1_HOME/etc/server_configuration.bash"

JAVA_HOME="$SWAPPSKAFANDER_T1_HOME/bonnet/lib/jre1.7.0_10"
export JAVA_HOME
PATH="$JAVA_HOME/bin:$PATH"

if [ "$S_USE_BUNDLED_RUBY_DISTRIBUTION" == "YES" ]; then
    echo ""
    echo "The server administration scripts use bundled ruby distribution."
    RUBY_HOME="$WAPPSKAFANDER_T1_HOME/bonnet/lib/ruby_v_1_9_3_linux_32b_i686"
    GEM_HOME="$RUBY_HOME/gem_home"
    export GEM_HOME
    export RUBY_HOME
    PATH="$RUBY_HOME/bin:$PATH"
else
    echo ""
    echo "The server administration scripts use system ruby distribution."
fi

JETTY_HOME="$WAPPSKAFANDER_T1_HOME/bonnet/jetty_8_1_8"
export JETTY_HOME
PATH="$JETTY_HOME/bin:$PATH"
export PATH
WAPPSKAFANDER_T1_FUNCSET_1_RB="$WAPPSKAFANDER_T1_HOME/bonnet/startup_script_complements/linux_32b_i686.rb"
WAPPSKAFANDER_T1_HOST_NAME="<currently not in use>" # $HOST_NAME"
WAPPSKAFANDER_T1_JETTY_PORT="$HTTP_PORT_NUMBER"
#-----------------------------------------
S_WAR_ORIGIN="$WAPPSKAFANDER_T1_HOME/servlet_project_in_maven_format/target"
S_JETTY_WEBAPPS="$JETTY_HOME/webapps"
export S_JETTY_WEBAPPS

#-----------------------------------------
S_TMP_1="$WAPPSKAFANDER_T1_HOME/bonnet/var/messaging"
mkdir -p $S_TMP_1
WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP="$S_TMP_1/message_stop_startup_t1.txt"
export WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP
chmod -f -R 0755 $WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP
rm -f $WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP

#-----------------------------------------

#==========================================================================

