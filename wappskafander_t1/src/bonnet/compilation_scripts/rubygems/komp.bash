#!/bin/bash
#==========================================================================

S_PARENT_FOLDER_OF_START_BASH="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

WAPPSKAFANDER_T1_HOME="$S_PARENT_FOLDER_OF_START_BASH/../../../"
export WAPPSKAFANDER_T1_HOME

RUBY_HOME="$WAPPSKAFANDER_T1_HOME/bonnet/lib/ruby_v_1_9_3_linux_32b_i686"
export RUBY_HOME
GEM_HOME="$RUBY_HOME/gem_home"
export GEM_HOME

PATH="$RUBY_HOME/bin:$PATH"
export PATH

#-----------------------------------------
S_RUBYGEMS_NAME="rubygems-1.8.24"

if [ -e ./$S_RUBYGEMS_NAME ]; then
if [ -d ./$S_RUBYGEMS_NAME ]; then
    chmod -f -R 0755 ./$S_RUBYGEMS_NAME
    rm -f -R ./$S_RUBYGEMS_NAME
fi
fi

tar -xf $S_RUBYGEMS_NAME.tar
#-----------------------------------------
cd  ./$S_RUBYGEMS_NAME

ruby -Ku ./setup.rb --prefix=$WAPPSKAFANDER_T1_HOME/bonnet/lib/rubygems_v_1_8_24_linux_32b_i686 --no-rdoc --no-ri 

#==========================================================================

