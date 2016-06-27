class CreateSpreeTemplateDesigns < ActiveRecord::Migration
  def change
    create_table :spree_template_designs do |t|
      t.references :design
      t.references :template
      t.timestamps null: false
    end

    add_index :spree_template_designs, :template_id
    add_index :spree_template_designs, :design_id
  end
end