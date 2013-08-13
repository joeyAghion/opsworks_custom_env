# Fast-apply an app's custom configuration.

node[:deploy].each do |application, deploy|

  # It would be nice to skip when the app's application_type isn't "rails,"
  # but that isn't supplied in the JSON when executing individual recipes.
  
  # Since the rails::configure recipe isn't always available, we must
  # re-declare this execute resource:
  # execute "restart Rails app #{application}" do
  #   cwd deploy[:current_path]
  #   command "#{deploy[:deploy_to]}/shared/scripts/unicorn restart"
  #   action :nothing
  # end
  
  custom_env_template do
    application application
    deploy deploy
    env node[:custom_env][application]
  end
  
end
