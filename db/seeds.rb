admin_role = Role.find_or_create_by!(label: :admin)
user_role = Role.find_or_create_by!(label: :normal)


# Open Permissions
Permission.create(controller: :sessions, action: :create, category: :open)
Permission.create(controller: :users, action: :login, category: :open)

for_admin = []
for_user = []

# Login permissions
for_user.push(Permission.create(controller: :sessions, action: :destroy))
for_user.push(Permission.create(controller: :devices, action: :index))
for_user.push(Permission.create(controller: :devices, action: :toggle))
for_user.push(Permission.create(controller: :devices, action: :create))
for_user.push(Permission.create(controller: :devices, action: :new))
for_user.push(Permission.create(controller: :devices, action: :edit))
for_user.push(Permission.create(controller: :devices, action: :update))


for_admin.push(Permission.create(controller: :users, action: :index))
for_admin.push(Permission.create(controller: :users, action: :add_role))
for_admin.push(Permission.create(controller: :users, action: :remove_role))

for_admin.each do |perm|
  admin_role.permissions.push(perm)
end

for_user.each do |perm|
  admin_role.permissions.push(perm)
  user_role.permissions.push(perm)
end
