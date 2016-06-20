class CreateSpreeDesigns < ActiveRecord::Migration
  def change
    create_table :spree_designs do |t|
      t.references :user
      t.references :template
      t.references :source

      t.attachment :rendering

      t.text :markup

      t.string :medium
      t.string :name
      t.float :popularity
      t.string :guest_token

      t.timestamp :deleted_at
      t.timestamps
    end

    add_index :spree_designs, :user_id
    add_index :spree_designs, :template_id
    add_index :spree_designs, :size
    add_index :spree_designs, :medium
  end
end