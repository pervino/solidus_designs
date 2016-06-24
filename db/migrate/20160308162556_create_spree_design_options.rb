class CreateSpreeDesignOptions < ActiveRecord::Migration
  def change
    create_table :spree_design_options do |t|
      enable_extension 'hstore'

      t.string :name
      t.string :label
      t.hstore :meta, default: {}
      t.integer :position

      t.string :medium

      t.references :design_configuration

      t.timestamp :deleted_at
      t.timestamps null: false
    end
  end
end