maintainer "Artsy"
description "Writes a config/application.yml file with custom ENV values to apps' deploy directories."
version "0.1"

recipe "opsworks_custom_env::configure", "Write a config/application.yml file to app's deploy directory. Relies on restart command declared by rails::configure recipe. (Intended as part of configure/deploy OpsWorks events.)"
