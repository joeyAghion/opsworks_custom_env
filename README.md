opsworks\_custom\_env
===================

This cookbook allows Rails apps on [Amazon OpsWorks](http://aws.amazon.com/opsworks/) to separate their configuration from their code. In keeping with [Heroku's twelve-factor app](http://www.12factor.net/config), the configuration is made available to the app's environment.

To accomplish this, the cookbook maintains a `config/application.yml` file in each respective app's deploy directory. E.g.:

    ---
    FOO: "http://www.yahoo.com"
    BAR: "1001"

Your application can then load its settings directly from this file, or use [Figaro](https://github.com/laserlemon/figaro) to automatically make these settings available in the app's `ENV` (recommended).

Configuration values are specified in the [stack's custom JSON](http://docs.aws.amazon.com/opsworks/latest/userguide/workingstacks-json.html). Example:

    {
      "custom_env": {
        "my_app": {
          "FOO": "http://www.yahoo.com",
          "BAR": "1001"
        }
      },
      
      "deploy": {
        "my_app": {
          "symlink_before_migrate": {
            "config/application.yml": "config/application.yml"
          }
        }
      }
    }

Note that the `symlink_before_migrate` attributes are necessary so that OpsWorks automatically symlinks the shared file when setting up release directories or deploying a new version.


Caveats
-------

At the moment, only Unicorn/Nginx-style Rails apps are supported.


Opsworks Set-Up
---------------

The `opsworks_custom_env::configure` recipe should be added as a custom recipe to the _Setup_, _Configure_, and _Deploy_ events.

A deploy is not necessary to update custom application environment values. Instead, update the Stack's custom JSON, then choose to _Run Command_ > _execute recipes_ and enter `opsworks_custom_env::update` into the _Recipes to execute_ field. Executing this recipe will write an updated `application.yml` file and restart the unicorn workers.
