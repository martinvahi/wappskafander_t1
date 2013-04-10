#!/usr/bin/env ruby -Ku 
#==========================================================================
=begin

 Copyright 2013, martin.vahi@softf1.com that has an
 Estonian personal identification code of 38108050020.
 All rights reserved.

 Redistribution and use in source and binary forms, with or
 without modification, are permitted provided that the following
 conditions are met:

 * Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer
   in the documentation and/or other materials provided with the
   distribution.
 * Neither the name of the Martin Vahi nor the names of its
   contributors may be used to endorse or promote products derived
   from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
 CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=end
#====================  start of boilerplate  ==============================

# The reason, why the following if-else blocks are not within a function
# is that the Ruby interpreter requires the constant initialization to be
# in the global scope. That does not stop the programmers to try to
# reinitialize the constants, like
#  A_CAT="Miisu"
#  A_CAT="Tom"
# , but, those are the rules.
x=ENV["WAPPSKAFANDER_T1_HOME"]
if (x==nil)||(x=="")
   puts("\nMandatory environment variable, WAPPSKAFANDER_T1_HOME, \n"+
   "has not been set.\n\n")
   exit
end # if
WAPPSKAFANDER_T1_HOME=x

KIBUVITS_HOME=WAPPSKAFANDER_T1_HOME+"/src/bonnet/wappskafander_t1_core"+
"/lib/kibuvits_ruby_library"

s_kibuvits_boot_path=KIBUVITS_HOME+"/src/include/kibuvits_boot.rb"
require s_kibuvits_boot_path

# Due to a fact that the API of the
# Kibuvits Ruby Library (KRL, http://kibuvits.rubyforge.org/ )
# is allowed to change between different versions,
# applications that use the KRL must be tied to a specific
# version of the KRL.
if !defined? KIBUVITS_s_NUMERICAL_VERSION
   msg="\nThe Ruby constant, KIBUVITS_s_NUMERICAL_VERSION, has not \n"+
   "been defined in the \n"+
   s_kibuvits_boot_path+
   ". That indicates a Kibuvits Ruby Library version mismatch.\n\n"
   puts msg
   exit
end # if
s_expected_KIBUVITS_s_NUMERICAL_VERSION="1.3.0"
if KIBUVITS_s_NUMERICAL_VERSION!=s_expected_KIBUVITS_s_NUMERICAL_VERSION
   msg="\nThis version of the mmmv_devel_tools expects the Ruby constant, \n"+
   "KIBUVITS_s_NUMERICAL_VERSION, to have the value of \""+s_expected_KIBUVITS_s_NUMERICAL_VERSION+"\", \n"+
   "but the KIBUVITS_s_NUMERICAL_VERSION=="+KIBUVITS_s_NUMERICAL_VERSION.to_s+"\n\n"
   puts msg
   exit
end # if

require KIBUVITS_HOME+"/src/include/kibuvits_str.rb"
require KIBUVITS_HOME+"/src/include/kibuvits_io.rb"
require KIBUVITS_HOME+"/src/include/kibuvits_fs.rb"
require KIBUVITS_HOME+"/src/include/kibuvits_shell.rb"

#--------------------------end-of-boilerplate------------------------------

# It's in a role of a namespace.
class Wappskafander_functionset_linux_t1

   def initialize
      @lc_s_war_globstring="*.[wW][aA][rR]" # war, WAR, WaR, wAr, etc.
   end # initialize

   #-----------------------------------------------------------------------

   def prepare_jetty_config_host_and_port
      throw(Exception.new("\n\nARGV.size!=3\n\n")) if ARGV.size!=3
      s_host=ARGV[1][1..(-1)] # has one character prefix to assure existence
      s_port=ARGV[2]

      s_fp_template_t1_jetty_xml=WAPPSKAFANDER_T1_HOME+
      "/src/bonnet/wappskafander_t1_core"+
      "/script_components/templates/template_t1_jetty_xml.txt"
      s_fp_jetty_xml=WAPPSKAFANDER_T1_HOME+"/src/bonnet/wappskafander_t1_core"+
      "/jetty_8_1_8/etc/jetty.xml"

      s_jetty_xml=file2str(s_fp_template_t1_jetty_xml)
      s_xmlr_end="</Set>"

      s_frag_1a="<Set name=\"port\"><Property name=\"jetty.port\" default=\""
      s_frag_1b="\"/>"
      s_jetty_xml=s_jetty_xml.sub((s_frag_1a+s_frag_1b+s_xmlr_end),
      (s_frag_1a+s_port+s_frag_1b)+(s_xmlr_end+"\n"))

      # The host part, the WAPPSKAFANDER_T1_HOST_NAME, etc.
      # is currently not in use, but one day it might be.
      #if 0<s_host.length
      #s_frag_2="<Property name=\"jetty.host\" />"
      #s_jetty_xml=s_jetty_xml.sub((s_frag_2+s_xmlr_end),s_frag_2+s_host+s_xmlr_end+"\n")
      #end # if

      #puts s_jetty_xml
      str2file(s_jetty_xml,s_fp_jetty_xml)
   end # prepare_jetty_config_host_and_port

   #-----------------------------------------------------------------------

   private
   #
   # Part of the credits go to:
   # http://www.enavigo.com/2008/08/29/deploying-a-web-application-to-jetty/
   #
   def prepare_jetty_config_war_contexts_create_config_file(s_war_fn_with_extension)
      # The file extensions can vary, like "WAR","war","WaR", etc.
      s_war_file_extensionless_name=s_war_fn_with_extension[0..(-5)] # "foo.war"
      s_fp_template=WAPPSKAFANDER_T1_HOME+
      "/src/bonnet/wappskafander_t1_core"+
      "/script_components/templates/template_t1_jetty_war_context_xml.txt"
      s_fp_destination_xml=WAPPSKAFANDER_T1_HOME+"/src/bonnet/wappskafander_t1_core"+
      "/jetty_8_1_8/contexts/"+s_war_file_extensionless_name+".xml"
      s_xml=file2str(s_fp_template)

      ht_needles=Hash.new
      ht_needles["WAPPSKAFANDER_BLANK_1"]=s_war_file_extensionless_name
      b_needle_is_key=true
      s_xml=Kibuvits_str.s_batchreplace(ht_needles, s_xml)

      #puts s_xml
      str2file(s_xml,s_fp_destination_xml)
   end #  prepare_jetty_config_war_contexts_create_config_file

   #-----------------------------------------------------------------------

   def s_symbolic_link_creation_command(s_fp_destination,s_fp_origin,s_ostype)
      s_out=nil
      case s_ostype
      when $kibuvits_lc_kibuvits_ostype_unixlike
         s_out=("ln -s "+s_fp_origin)+($kibuvits_lc_space+s_fp_destination+" ; \n")
         # Windows 7 and 8 support symbolic links in the form of shortcut files
         #when $kibuvits_lc_kibuvits_ostype_windows
      else
         throw(Exception.new("\s_ostype==\""+s_ostype.to_s+
         "\" is not yet supported."+
         "\nGUID='502524a2-7dbe-471a-aa3a-516260e0acd7'\n"))
      end # case s_mode
      return s_out
   end # s_symbolic_link_creation_command

   #-----------------------------------------------------------------------

   # s_ostype inSet { $kibuvits_lc_kibuvits_ostype_windows,
   #                  $kibuvits_lc_kibuvits_ostype_unixlike }
   def prepare_jetty_config_wars_impl(s_fp_parent_folder,s_ostype)
      b_return_long_paths=false
      ar_war_fn_with_extension=Kibuvits_fs.ar_glob_locally_t1(
      s_fp_parent_folder,@lc_s_war_globstring,b_return_long_paths) # war, WAR, WaR, wAr, etc.
      ar_s_cmd=Array.new
      cmd=nil
      s_fp_origin=nil
      s_fp_destination=nil
      s_fp_origin_prefix=s_fp_parent_folder+$kibuvits_lc_slash
      s_fp_destination_prefix=WAPPSKAFANDER_T1_HOME+
      "/src/bonnet/wappskafander_t1_core/jetty_8_1_8/webapps/"
      ar_war_fn_with_extension.each do |s_war_fn_with_extension|
         s_fp_origin=s_fp_origin_prefix+s_war_fn_with_extension
         s_fp_destination=s_fp_destination_prefix+s_war_fn_with_extension
         cmd=s_symbolic_link_creation_command(s_fp_destination,s_fp_origin,
         s_ostype)
         ar_s_cmd<<cmd
      end # loop
      cmd=kibuvits_s_concat_array_of_strings(ar_s_cmd)
      ht_stdstreams=nil
      ht_stdstreams=sh(cmd)
      if ht_stdstreams.class==Hash
         s_stdout=ht_stdstreams[$kibuvits_lc_s_stdout]
         s_stderr=ht_stdstreams[$kibuvits_lc_s_stderr]
         if 0<s_stderr.length
            puts s_stderr
            exit
         end # if
         # As the Jetty server monitors the contexts folder for the xml files,
         # the symlinks to the war files should be in place before the
         # context files are created.
         ar_war_fn_with_extension.each do |s_war_fn_with_extension|
            prepare_jetty_config_war_contexts_create_config_file(s_war_fn_with_extension)
         end # loop
      else
         throw(Exception.new("\ns_ostype=="+s_ostype.to_s+
         "\ncmd=="+cmd+"\nGUID='502524a2-7dbe-471a-aa3a-516260e0acd7'\n"))
      end # if
   end # prepare_jetty_config_wars_impl

   def ar_get_servlet_project_warfile_folder_paths
      s_fp_servlet_projects=WAPPSKAFANDER_T1_HOME+
      "/src/servlet_projects_in_maven_format"
      b_return_long_paths=false
      ar_names=Kibuvits_fs.ar_glob_locally_t1(s_fp_servlet_projects,
      "*",b_return_long_paths)
      ar_out=Array.new
      s_fp_candidate=nil
      ar=nil
      s_lc_1="/target"
      s_lc_2=$kibuvits_lc_slash+@lc_s_war_globstring
      ar_names.each do |s_name|
         s_fp_candidate=s_fp_servlet_projects+($kibuvits_lc_slash+s_name+s_lc_1)
         next if !File.exists? s_fp_candidate
         next if !File.directory? s_fp_candidate
         ar=Dir.glob(s_fp_candidate+s_lc_2)
         next if ar.size==0
         ar_out<<s_fp_candidate
      end # loop
      return ar_out
   end # ar_get_servlet_project_warfile_folder_paths

   def assert_absence_of_war_file_name_conficts(ar_parent_folder_paths)
      ht=Hash.new
      b_stop=false
      s_fn_extensionless=nil
      s_fp_2=nil
      ar_war_fn_with_extension=nil
      b_return_long_paths=false
      ar_parent_folder_paths.each do |s_fp_parent_folder|
         ar_war_fn_with_extension=Kibuvits_fs.ar_glob_locally_t1(
         s_fp_parent_folder,@lc_s_war_globstring,b_return_long_paths)
         ar_war_fn_with_extension.each do |s_war_fn_with_extension|
            s_fn_extensionless=s_war_fn_with_extension[0..(-5)] # "foo.war"
            s_fp_2=s_fp_parent_folder+($kibuvits_lc_slash+s_war_fn_with_extension)
            if ht.has_key? s_fn_extensionless
               b_stop=true
               break
            end # if
            break if b_stop
            ht[s_fn_extensionless]=s_fp_2
         end # loop
      end # loop
      if b_stop
         s_fp_1=ht[s_fn_extensionless]
         msg="\nThere is a name collision between \n"+s_fp_1+
         "\nand\n"+s_fp_2+"\n"
         if s_fp_1[(-3)..(-1)]!=s_fp_2[(-3)..(-1)]
            msg=msg+"The difference in letter case of the file "+
            "name extensions does not count.\n"
         end # if
         msg=msg+"\n"
         puts msg
         s_fp=ENV["WAPPSKAFANDER_T1_FP_2_MSG_STOP_STARTUP"]
         # The existence of that file notifies the bash script
         # that it should start the server.
         str2file(msg,s_fp)
         exit
      end # if
   end # assert_absence_of_war_file_name_conficts

   #-----------------------------------------------------------------------

   public
   def prepare_jetty_config_all_war_contexts
      throw(Exception.new("\n\nARGV.size!=2\n\n")) if ARGV.size!=2
      s_ostype=ARGV[1]

      # The reason, why I use the sub-optimal, multiple-glob based,
      # approach here is that I really hesitate to do
      # manual file path parsing. E.g. backslashes are OK in
      # Linux file names and if that code were to be used on Windows ...
      # And no, in practice I do not buy the talk about Windows
      # fully supporting ordinary slashes in file paths.

      ar_parent_folder_paths=ar_get_servlet_project_warfile_folder_paths()

      s_fp_web_root=WAPPSKAFANDER_T1_HOME+"/src/web_root"
      if 0<(Dir.glob(s_fp_web_root+$kibuvits_lc_slash+@lc_s_war_globstring)).size
         ar_parent_folder_paths<< s_fp_web_root
      end # if

      assert_absence_of_war_file_name_conficts(ar_parent_folder_paths)
      ar_parent_folder_paths.each do |s_fp_folder|
         prepare_jetty_config_wars_impl(s_fp_folder,s_ostype)
      end # loop
   end # prepare_jetty_config_all_war_contexts

end # class Wappskafander_functionset_linux_t1


throw(Exception.new("\n\nARGV.size==0\n\n")) if ARGV.size==0

s_funcname=ARGV[0]
ob_funcset=Wappskafander_functionset_linux_t1.new

case s_funcname
when "prepare_jetty_config_host_and_port"
   ob_funcset.prepare_jetty_config_host_and_port()
when "prepare_jetty_config_all_war_contexts"
   ob_funcset.prepare_jetty_config_all_war_contexts()
else
   throw(Exception.new("\n\ns_funcname=="+s_funcname.to_s+
   "\nis not supported.\n\n"))
end # case s_funcname


#==========================================================================
