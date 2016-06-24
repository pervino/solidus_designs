class CreateSpreeDesignConfigurations < ActiveRecord::Migration
  def change
    create_table :spree_design_configurations do |t|
      enable_extension 'hstore'

      t.string :name
      t.boolean :required, default: true

      t.string :size
      t.string :type
      t.integer :position

      t.references :product

      t.hstore :meta, default: {}

      t.boolean :virtual_proofable, default: false

      t.timestamp :deleted_at
      t.timestamps null: false
    end
  end
end