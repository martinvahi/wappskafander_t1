#!/bin/bash
#==========================================================================

source "$S_PARENT_FOLDER_OF_START_BASH/../bonnet/startup_script_complements/linux_32b_i686_common.bash"

#-----------------------------------------
chmod -f 0755 $JETTY_HOME/etc/jetty.xml
ruby -Ku $WAPPSKAFANDER_T1_FUNCSET_1_RB prepare_jetty_config_host_and_port "x$WAPPSKAFANDER_T1_HOST_NAME" $WAPPSKAFANDER_T1_JETTY_PORT
#-----------------------------------------

if [ "$1" == "light" ]; then
    echo "Copy of the list of WAR files will not be updated."
else
    echo "Updating the list of WAR files ..."
    #---------------------------------------------------
    mkdir -p $JETTY_HOME/webapps
    chmod -f -R 0755 $JETTY_HOME/webapps
    rm -f $S_JETTY_WEBAPPS/root # to remove a symlink without following it
    rm -f -R $S_JETTY_WEBAPPS/root # to make sure that the folder named root really becomes a symlink
    ln -s $WAPPSKAFANDER_T1_HOME/web_root $S_JETTY_WEBAPPS/root
    #---------------------------------------------------
    chmod -f -R 0755 $JETTY_HOME/contexts
    # As the contexts folder is probably empty, it might be missing from the Git repository.
    mkdir -p $JETTY_HOME/contexts 
    rm -f $JETTY_HOME/contexts/*
    rm -f -R $S_JETTY_WEBAPPS/*.war
    ruby -Ku $WAPPSKAFANDER_T1_FUNCSET_1_RB prepare_jetty_config_all_war_contexts kibuvits_ostype_unixlike
    cp -f $WAPPSKAFANDER_T1_HOME/bonnet/startup_script_complements/templates/root_context.xml $JETTY_HOME/contexts/
fi
echo""

#-----------------------------------------

#==========================================================================

