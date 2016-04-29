class MigrateLineItemsToSolidusDesigns < ActiveRecord::Migration
  def up
    say_with_time 'Migrating line items' do
      Spree::LineItem.where('design_id IS NOT NULL').find_each do |line_item|
        line_item.update_column("customization_total", line_item.design_fee_total)
        design = Spree::Design.find_by(id: line_item.design_id)
        next unless design

        customization = line_item.customizations.build(source_id: line_item.design_id, source_type: "Spree::Design")

        unless line_item.variant.product.design_configurations.any?
          next unless line_item.variant.product.design_configurations.create(size: design.size, name: 'Front of Bottle').persisted?
          puts "Creating new design configuration for ##{line_item.variant.name}"
        end

        customization.configuration = line_item.variant.product.design_configurations.first

        unless customization.configuration.design_options.find_by(medium: design.medium)
          next unless customization.configuration.design_options.create(name: design.medium, medium: design.medium).persisted?
          puts "Creating new design option for line item ##{line_item.id}"
        end

        customization.option = customization.configuration.design_options.find_by(medium: design.medium)

        line_item.adjustments.where(source_type: 'Spree::DesignFee').each do |adjustment|
          adjustment.source = customization.option
          adjustment.save!
        end

        customization.save!
      end
    end

    drop_column :spree_line_items, :design_fee_total
    drop_column :spree_line_items, :design_id
    drop_column :spree_line_items, :customization_type
    drop_column :spree_line_items, :customization_id
    drop_column :spree_line_items, :dynamic_mockup_url
    drop_column :spree_line_items, :needs_dynamic_image_save_flag
    drop_attached_file :spree_line_items, :mockup

    Spree::Order.update_all("customization_total=design_fee_total")
  end

  def down
  end
end
