maintainer "Artsy"
description "Writes a config/application.yml file with custom ENV values to apps' deploy directories."
version "0.1"

recipe "opsworks_custom_env::configure", "Write a config/application.yml file to app's deploy directory. Relies on restart command declared by rails::configure recipe. (Intended as part of configure/deploy OpsWorks events.)"
recipe "opsworks_custom_env::update", "Write an updated config/application.yml and restart the app. Can be run independently of OpsWorks configure/deploy events."

# This actually depends on the rails::configure recipe by OpsWorks, but not
# declaring that here to prevent librarian-chef failure.
# depends "rails::configure"
