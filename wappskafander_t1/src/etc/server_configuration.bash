


# If the WAR file has the name of "frankestein.war", then 
# the demo versions of the following two 
# configuration values will yield: 
#
# http://localhost:20040/frankestein/

HTTP_PORT_NUMBER="20040"   

# Even though the server, the Java servlet
# container,  runs on Java, its 
# start-up scripts depend on Ruby. 
# 
# As the Java based Ruby distribution, the JRuby, 
# has problems handling UTF-8 Ruby source files and
# no other machine independent Ruby distributions 
# is available, the start up scripts have to 
# use either the Ruby distribution that 
# has been installed to the local machine or 
# use the version that has been bundled with this
# servlet runner.

S_USE_BUNDLED_RUBY_DISTRIBUTION="YES"


