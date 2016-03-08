class MigrateTemplateToSolidusDesigns < ActiveRecord::Migration
  def change
    rename_column :spree_templates, :design_type, :medium
  end
end
