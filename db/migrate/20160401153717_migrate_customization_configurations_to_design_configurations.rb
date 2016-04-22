class MigrateCustomizationConfigurationsToDesignConfigurations < ActiveRecord::Migration
  class Spree::DesignFee < Spree::Base
  end;

  class Spree::CustomizationConfiguration < Spree::Base
    belongs_to :product
    belongs_to :design_fee
  end;

  class Spree::CustomizationConfiguration::Custom < Spree::CustomizationConfiguration
  end;

  class Spree::CustomizationConfiguration::CustomStatic < Spree::CustomizationConfiguration
  end;

  class Spree::CustomizationConfiguration::Static < Spree::CustomizationConfiguration
  end;

  class Spree::CustomizationConfiguration::Template < Spree::CustomizationConfiguration
  end;

  def up
    sizeMap = {
        'standard' => 'bordeaux',
        'wide' => 'teardrop',
        'square' => 'square'
    }

    say_with_time 'Migrating customization configurations' do
      Spree::CustomizationConfiguration::Custom.find_each do |customization_configuration|
        next unless (product = customization_configuration.product) && (design_fee = customization_configuration.design_fee)

        design_configuration = product.design_configurations.create(
            name: 'Front of bottle',
            size: sizeMap[customization_configuration.preferences[:design_size]],
            virtual_proofable: product.dynamic_imaging_flag
        )
        design_configuration.save!

        customization_configuration.preferences[:design_types].each do |medium|
          design_option = design_configuration.design_options.create(
              name: medium.titlecase,
              medium: medium,
              calculator: Spree::Calculator::FlatRatePerItem.new)
          design_option.save!

          design_option.calculator.set_preference('amount', design_fee.preferences[:pricing][medium.to_sym])
          design_option.calculator.save!
        end
      end
    end

    remove_column :spree_products, :dynamic_imaging_flag
    drop_table :spree_customization_configurations
  end

  def down
  end
end

