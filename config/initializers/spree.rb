Spree::RoleConfiguration.configure do |config|
  config.assign_permissions :default, [SpreeDesigns::PermissionSets::DefaultCustomer]
end
