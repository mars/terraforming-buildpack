Terraforming 🌱 buildpack for Heroku
==================================

Apply a Terraform config in the build process of a Heroku app.

* supports arbitrary `TF_*` config variables such as [`TF_VAR_*`](https://www.terraform.io/docs/configuration/variables.html#environment-variables)
* caches state `terraform.tfstate` in the build cache
* stores the Terraform outputs JSON in the slug: `terraform-data/outputs.json`

🚨🔬 **This is a proof of concept. Not production ready.** This buildpack treats the inputs & outputs as if they are not sensitive, secret data.

Usage
-----

In a git repo that contains at least a `main.tf` Terraform config file,

```bash
heroku create --buildpack https://github.com/mars/terraforming-buildpack

# Set any variables required by the Terraform config
heroku config:set TF_VAR_aws_region=us-west-2

git push heroku master
```

Development
-----------

Rather crude but functional dev on macOS:

```bash
# Make a copy of the test data.
cp -r test-data tmp

# Execute the build process in that tmp directory structure.
TERRAFORM_BIN_URL=https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_darwin_amd64.zip \
  ./bin/compile $(pwd)/tmp/build $(pwd)/tmp/cache $(pwd)/tmp/env

# Once complete,
#  inspect the slug in `tmp/build/`
#  inspect the state in `tmp/terraform_state/`

# Clean-up before the next test run.
rm -rf tmp/
```

Configuration
-------------

* `TERRAFORM_BIN_URL` set the source URL for the terraform binary
  * Defaults to 64-bit Linux binary for Heroku runtime
  * Expects a `*.zip` file as [distributed by Hashicorp](https://www.terraform.io/downloads.html)
