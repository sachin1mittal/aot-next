admin_role = Role.find_or_create_by!(label: :admin)
user_role = Role.find_or_create_by!(label: :normal)


# Open Permissions
Permission.find_or_create_by!(controller: :sessions, action: :create, category: :open)
Permission.find_or_create_by!(controller: :sessions, action: :login, category: :open)

for_admin = []
for_user = []

# Login permissions
for_user.push(Permission.find_or_create_by!(controller: :sessions, action: :destroy))
for_user.push(Permission.find_or_create_by!(controller: :devices, action: :index))
for_user.push(Permission.find_or_create_by!(controller: :devices, action: :toggle))
for_user.push(Permission.find_or_create_by!(controller: :devices, action: :create))
for_user.push(Permission.find_or_create_by!(controller: :devices, action: :destroy))
# for_user.push(Permission.find_or_create_by!(controller: :devices, action: :new))
# for_user.push(Permission.find_or_create_by!(controller: :devices, action: :edit))
for_user.push(Permission.find_or_create_by!(controller: :devices, action: :update))
for_user.push(Permission.find_or_create_by!(controller: :devices, action: :show))
for_user.push(Permission.find_or_create_by!(controller: :devices, action: :script))
for_user.push(Permission.find_or_create_by!(controller: :devices, action: :add_user))
for_user.push(Permission.find_or_create_by!(controller: :devices, action: :dummy))
for_user.push(Permission.find_or_create_by!(controller: :devices, action: :sdks))
# for_user.push(Permission.find_or_create_by!(controller: :devices, action: :add_network))
for_user.push(Permission.find_or_create_by!(controller: :devices, action: :remove_user))
# for_user.push(Permission.find_or_create_by!(controller: :networks, action: :index))
# for_user.push(Permission.find_or_create_by!(controller: :networks, action: :destroy))
# for_user.push(Permission.find_or_create_by!(controller: :networks, action: :create))
# for_user.push(Permission.find_or_create_by!(controller: :networks, action: :new))
# for_user.push(Permission.find_or_create_by!(controller: :networks, action: :edit))
# for_user.push(Permission.find_or_create_by!(controller: :networks, action: :update))
# for_user.push(Permission.find_or_create_by!(controller: :networks, action: :add_device))
# for_user.push(Permission.find_or_create_by!(controller: :networks, action: :remove_device))
# for_user.push(Permission.find_or_create_by!(controller: :users, action: :change_token))
# for_user.push(Permission.find_or_create_by!(controller: :users, action: :edit))
for_user.push(Permission.find_or_create_by!(controller: :users, action: :show))
for_user.push(Permission.find_or_create_by!(controller: :users, action: :help))
for_user.push(Permission.find_or_create_by!(controller: :users, action: :dashboard))
# for_user.push(Permission.find_or_create_by!(controller: :users, action: :update))
# for_user.push(Permission.find_or_create_by!(controller: :users, action: :destroy))
for_user.push(Permission.find_or_create_by!(controller: :users, action: :search_by_email))


# for_admin.push(Permission.find_or_create_by!(controller: :users, action: :index))
# for_admin.push(Permission.find_or_create_by!(controller: :users, action: :add_role))
# for_admin.push(Permission.find_or_create_by!(controller: :users, action: :remove_role))

for_admin.each do |perm|
  admin_role.permissions.push(perm) if not admin_role.permission_ids.include?(perm.id)
end

for_user.each do |perm|
  admin_role.permissions.push(perm) if not admin_role.permission_ids.include?(perm.id)
  user_role.permissions.push(perm) if not user_role.permission_ids.include?(perm.id)
end
