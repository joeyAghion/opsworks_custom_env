maintainer "Artsy"
description "Writes a config/application.yml file with custom ENV values to apps' deploy directories."
version "0.2"

recipe "opsworks_custom_env::deploy", "Write custom configuration and notify rails application to restart (depends on rails::configure recipe, so useful in deploy event)."
recipe "opsworks_custom_env::update", "Write custom configuration and restart rails app with own command (doesn't depend on rails::configure recipe, so useful for ad-hoc configuration changes)."
recipe "opsworks_custom_env::write_config", "Write a config/application.yml file to app's deploy directory. Used by deploy and update recipes, or can be used directly in custom situations."

# We depend on the rails::configure recipe by OpsWorks, but commenting this out to avoid
# librarian-chef errors.
# depends "rails::configure"
