module SpreeDesigns
  class Engine < Rails::Engine
    engine_name 'solidus_designs'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      ['app', 'lib'].each do |dir|
        Dir.glob(File.join(File.dirname(__FILE__), "../../#{dir}/**/*_decorator*.rb")) do |c|
          Rails.application.config.cache_classes ? require(c) : load(c)
        end
      end
    end

    config.to_prepare &method(:activate).to_proc

    initializer "spree.design.environment", before: :load_config_initializers do |app|
      # Legacy way of doing this
      Spree::Designs::Config = Spree::Designs::AppConfiguration.new
    end

    initializer "spree.customization.register.calculators", after: "spree.register.calculators" do |app|
      app.config.spree.calculators.add_class('design')
      app.config.spree.calculators.design = %w[
        Spree::Calculator::FlatRatePerItem
      ]
    end
  end
end
