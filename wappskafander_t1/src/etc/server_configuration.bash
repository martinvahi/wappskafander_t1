


# If the WAR file has the name of "frankestein.war", then
# the demo versions of the following two
# configuration values will yield:
#
# http://localhost:20040/frankestein/

WAPPSKAFANDER_T1_HTTP_PORT_NUMBER="20040"

# Even though the server, the Java servlet
# container,  runs on Java, its
# start-up scripts depend on Ruby.
#
# The Java based Ruby distribution, the JRuby,
# has problems handling UTF-8, which entails that
# the start up scripts can not be executed by JRuby.
#
# The startup scripts depend on Ruby 2.x.x
# If the installed version of Ruby is older, then
# an optional Ruby home folder can be provided
# by an environment variable:
#
# MMMV_RUBY_HOME="<path to the Ruby home folder>

