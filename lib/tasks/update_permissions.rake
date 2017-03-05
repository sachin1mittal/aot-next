namespace :auth do
  desc "Add New Permissions"
  task update_permissions: :environment do
    UserManager.update_permissions
  end
end
