class UserManager

  PERMISSIONS_FILE_PATH = '/home/sachin/tasks/aot-next/config/permissions.yml'

  def self.update_permissions
    permissions = HashWithIndifferentAccess.new(YAML.load(File.read(
                           File.expand_path(PERMISSIONS_FILE_PATH, __FILE__))))
    open_permissions = permissions.delete(:open)

    open_permissions.each do |controller_name, action_names|
      action_names.each do |action|
        Permission.find_or_create_by!(controller: controller_name, action: action, category: :open)
      end
    end

    permissions.each do |controller_name, action_names|
      action_names.each do |action|
        Permission.find_or_create_by!(controller: controller_name, action: action)
      end
    end

  end
end
