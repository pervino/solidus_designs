class MigrateDesignsToSolidusDesigns < ActiveRecord::Migration
  disable_ddl_transaction!

  def change
    execute "ALTER INDEX designs_pkey RENAME TO spree_designs_pkey;"

    Spree::Design.where(is_legacy: true).delete_all

    rename_column :spree_designs, :design_type, :medium
    rename_column :spree_designs, :design_size, :size

    remove_column :spree_designs, :old_small
    remove_column :spree_designs, :old_medium
    remove_column :spree_designs, :old_full

    remove_column :spree_designs, :lablr_design_id
    remove_column :spree_designs, :older_template_id
    remove_column :spree_designs, :is_legacy
    remove_column :spree_designs, :risky

    add_column :spree_designs, :type, :string
    add_column :spree_designs, :source_id, :integer

    rename_column :spree_designs, :markup, :old_markup
    add_column :spree_designs, :markup, :text
    add_column :spree_designs, :render_url, :string

    say_with_time 'Migrating design data' do
      Spree::Design.find_each do |design|
        sizeMap = {
            'standard' => 'bordeaux',
            'wide' => 'teardrop',
            'square' => 'square'
        }

        design.update_columns(render_url: design.images["large"],
                              markup: YAML::load(design.old_markup),
                              size: sizeMap[design.size])
      end
    end

    remove_column :spree_designs, :old_markup
    remove_column :spree_designs, :images

    Spree::Design.where(is_template: true).where("template_id IS NOT NULL").find_each do |design|
      Spree::TemplateDesign.create(template: design.template, design: design)
    end

    remove_column :spree_designs, :is_template

    add_index :spree_designs, [:template_id]
    add_index :spree_designs, [:user_id]
    add_index :spree_designs, [:guest_token]
    add_index :spree_designs, [:medium]
  end
end
