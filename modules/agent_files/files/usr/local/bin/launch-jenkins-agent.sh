#!/bin/sh

servicename=jenkins-slave

if [ -r /etc/default/$servicename ]; then
	. /etc/default/$servicename
fi

# load environments
if [ -r /etc/default/locale ]; then
  . /etc/default/locale
  export LANG LANGUAGE
elif [ -r /etc/environment ]; then
  . /etc/environment
  export LANG LANGUAGE
fi


# --user in daemon doesn't prepare environment variables like HOME, USER, LOGNAME or USERNAME,
# so we let su do so for us now
/bin/su -l $JENKINS_SLAVE_USER --shell=/bin/bash -c "$JAVA $JAVA_ARGS -jar $JENKINS_SLAVE_JAR $JENKINS_SLAVE_ARGS"
