require 'spec_helper'

module Spree
  describe Spree::Designs::ProductDuplicator, type: :model do
    let(:source_product) { create(:product, design_configurations: [create(:design_configuration, design_options: [create(:design_option)])]) }
    let(:destination_product) { create(:product) }
    let!(:duplicator) { Spree::Designs::ProductDuplicator.new(destination_product, source_product) }

    context "with design configurations" do
      it "will duplicate the design configurations" do
        expect { duplicator.duplicate }.to change { Spree::DesignConfiguration.count }.by(1)
      end

      context "design configuration attributes" do
        before do
          duplicator.duplicate
        end

        it "copied the name" do
          expect(destination_product.design_configurations.first.name).to eql source_product.design_configurations.first.name
        end
      end

      context "with design options" do
        it "will duplicate the design options" do
          expect { duplicator.duplicate }.to change { Spree::DesignOption.count }.by(1)
        end

        it "will duplicate the design option calculators" do
          expect { duplicator.duplicate }.to change { Spree::Calculator.count }.by(1)
        end

        context "design configuration attributes" do
          before do
            duplicator.duplicate
          end

          it "copied the name" do
            expect(destination_product.design_configurations.first.design_options.first.name).to eql source_product.design_configurations.first.design_options.first.name
          end
        end
      end
    end
  end
end