# Artifactory Raspberry Pi
Dockerfile for Artifactory OSS 6.13.1 to be ran on ARM-based systems as the official
image from JFrog does not appear to work. Primarily tested on a Raspberry Pi 4
running Raspbian GNU/Linux 10 (buster).

JVM for the Tomcat server is created and allocated with a max heap size of 2g. May be
adjustable via EXTRA_JAVA_OPTIONS as the documentation from JFrog suggests.

## Docker Settings
Exposed Port(s):
  - 8081

Volume Mount(s):
  - /artifactory/data
  - /artifactory/logs
  - /artifactory/backup
