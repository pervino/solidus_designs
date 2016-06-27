# require 'spec_helper'
#
# RSpec.describe Spree::Designs::ItemAdjuster do
#   subject(:adjuster) { described_class.new(item) }
#   let(:order) { Spree::Order.new }
#   let(:item) { Spree::LineItem.new(order: order) }
#
#   describe 'initialization' do
#     it 'sets adjustable' do
#       expect(adjuster.item).to eq(item)
#     end
#   end
#
#   describe '#adjust!' do
#     context 'when the item has no customizations' do
#       before do
#         adjuster.adjust!
#       end
#
#       it 'returns nil early' do
#         expect(adjuster.adjust!).to be_nil
#       end
#     end
#
#     context 'when the item has customizations' do
#       let(:item) { build_stubbed :line_item, order: order }
#       let(:design_option) { create :design_option }
#       # let(:customizations) { build_stubbed(:zone, :with_country) }
#
#       before do
#         expect(Spree::TaxRate).to receive(:for_zone).with(tax_zone).and_return(rates_for_order_zone)
#         expect(Spree::TaxRate).to receive(:for_zone).with(Spree::Zone.default_tax).and_return([])
#       end
#
#
#       it 'creates an adjustment for every non-zero adjustment' do
#         expect(design_option).to receive_message_chain(:adjustments, :create!)
#         expect(adjuster.adjust!.length).to eq(1)
#       end
#     end
#   end
# end
