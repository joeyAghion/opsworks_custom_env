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

The `opsworks_custom_env::configure` recipe should be added as a custom recipe to the _Deploy_ event. It executes a _restart Rails app APPNAME_ resource when the settings have changed, so ensure that this is defined. (In a typical rails layer, this is provided by the `rails::configure` recipe.)
