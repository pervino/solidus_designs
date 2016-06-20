class CreateSpreeTemplates < ActiveRecord::Migration
  def change
    create_table :spree_templates do |t|
      t.string :name
      t.string :medium
      t.boolean :display, default: true

      t.float :popularity

      t.timestamp :deleted_at
      t.timestamps
    end

    add_index :spree_templates, :medium
  end
end