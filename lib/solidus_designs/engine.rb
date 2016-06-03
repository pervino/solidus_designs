module SolidusDesigns
  class Engine < Rails::Engine
    require "solidus_core"

    isolate_namespace Spree
    engine_name 'solidus_designs'

    initializer "spree.design.environment", before: :load_config_initializers do |app|
      Spree::Designs::Config = Spree::Designs::AppConfiguration.new
    end

    initializer "spree.customization.register.calculators", after: "spree.register.calculators" do |app|
      app.config.spree.calculators.add_class('design')
      app.config.spree.calculators.design = %w[
          Spree::Calculator::FlatRatePerItem
      ]
    end

    initializer "spree.design.register.customization_sources", after: 'spree.customization.register.customization_sources' do |app|
      app.config.spree.customization.source_configurations << "Spree::DesignConfiguration"
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), '../spree/**/*_decorator.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
