RSpec.describe Spree::DesignConfiguration, type: :model do

  describe "#adjust" do
    let(:order) { create(:order_with_line_items) }
    let(:design_option) { create(:design_option) }
    let(:design_configuration) { create(:design_configuration) }
    let(:design) { create(:design) }

    let(:item) { order.line_items.first }

    before do
      design_option.calculator = Spree::Calculator::FlatRatePerItem.new(preferred_amount: 15)
    end

    it "should create an adjustment with correct amount" do
      design_option.adjust(item)
      expect(item.adjustments.customization.count).to eq(1)
      expect(item.adjustments.customization.first.amount.to_i).to eq(15)
    end

    describe 'adjustments' do
      let(:adjustment_label) { item.adjustments.customization.first.label }

      context 'with label' do
        before do
          design_option.label = "Custom Adjustment Label"
        end

        it 'shows the design option adjustment_label as the label' do
          design_option.adjust(item)
          expect(adjustment_label).to eq(design_option.label)
        end
      end

      context 'without label' do
        it 'shows the default as the label' do
          design_option.adjust(item)
          expect(adjustment_label).to eq("Personalization")
        end
      end
    end
  end
end