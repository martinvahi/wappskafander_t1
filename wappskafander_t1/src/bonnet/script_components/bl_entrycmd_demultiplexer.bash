#!/bin/bash
#==========================================================================
source "$WAPPSKAFANDER_T1_HOME/src/bonnet/script_components/bl_init_environment_variables.bash"
#--------------------------------------------------------------------------

if [ "$S_ENTRYCMD" == "start_server" ]; then
    source "$WAPPSKAFANDER_T1_HOME/src/bonnet/script_components/bl_startup_part_x1.bash"
    cd $JETTY_HOME/bin
    if [ ! -e $WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP ]; then
        echo ""
        echo "A few reminders from the \$WAPPSKAFANDER_T1_HOME/src/etc/server_configuration.bash: "
        echo "        HTTP_PORT_NUMBER==$HTTP_PORT_NUMBER"
        echo "        ----end-of-list----"
        echo ""
        jetty.sh start
    else
        echo "Server startup sequence aborted."
        echo ""
        chmod -f 0755 $WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP 
        rm -f $WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP 
    fi
fi

#--------------------------------------------------------------------------

if [ "$S_ENTRYCMD" == "stop_server" ]; then
    cd $JETTY_HOME/bin
    jetty.sh stop
fi

#==========================================================================
