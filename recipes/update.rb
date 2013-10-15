# No 'restart Rails app <name>' command is defined during ad hoc configuration changes (e.g.,
# outside the deploy event), so we must define it first.

if node[:opsworks][:instance][:layers].include?('rails-app')
  node[:deploy].each do |application, deploy|
  
    # It would be nice to skip when the app's application_type isn't "rails,"
    # but that isn't supplied in the JSON when executing individual recipes.
    
    execute "restart Rails app #{application}" do
      cwd deploy[:current_path]
      command "#{deploy[:deploy_to]}/shared/scripts/unicorn restart"
      action :nothing
    end

  end

  include_recipe "opsworks_custom_env::write_config"
end
