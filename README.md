Terraforming 🌱 buildpack for Heroku
==================================

Use [Terraform](https://www.terraform.io/) in a [Heroku](https://www.heroku.com/) app.

Requires
--------

The Terraform config must implement a non-local [backend](https://www.terraform.io/docs/backends/index.html), because otherwise state will be lost between runs. The default local backend saves state in the filesystem which [ephemeral in Heroku dynos](https://devcenter.heroku.com/articles/dynos#ephemeral-filesystem).

Usage
-----

In a git repo that contains at least a `main.tf` Terraform config file,

```bash
heroku create --buildpack https://github.com/mars/terraforming-buildpack

# Set any variables required by the Terraform config
heroku config:set TF_VAR_heroku_api_key=xxxxx

git push heroku master

heroku run terraform init
heroku run terraform apply
heroku run terraform output
```

Configuration
-------------

* `TERRAFORM_BIN_URL` set the source URL for the terraform binary
  * Defaults to 64-bit Linux binary for Heroku runtime
  * Expects a `*.zip` file as [distributed by Hashicorp](https://www.terraform.io/downloads.html)
