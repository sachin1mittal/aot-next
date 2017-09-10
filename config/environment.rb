# Load the Rails application.
require File.expand_path('../application', __FILE__)

app_environment_variables = File.join("/home/sachin/apps/aot-next/app_environment_variables.rb")
load(app_environment_variables) if File.exists?(app_environment_variables)

# Initialize the Rails application.
Rails.application.initialize!
