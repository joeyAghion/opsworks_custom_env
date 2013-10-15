# During deploy event, a 'restart Rails app <name>' command is already defined, so
# we simply include that recipe and notify the existing "resource."

include_recipe "rails::configure"
include_recipe "opsworks_custom_env::write_config"
