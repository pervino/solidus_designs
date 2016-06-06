Spree::RoleConfiguration.configure do |config|
  config.assign_permissions :default, [Spree::Designs::PermissionSets::DefaultCustomer]
end