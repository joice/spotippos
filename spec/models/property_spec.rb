require 'rails_helper'

RSpec.describe Property, type: :model do
  describe '#validations' do
    it { is_expected.to validate_numericality_of(:x).only_integer.is_less_than_or_equal_to(1400).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:y).only_integer.is_less_than_or_equal_to(1000).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:beds).only_integer.is_less_than_or_equal_to(5).is_greater_than_or_equal_to(1) }
    it { is_expected.to validate_numericality_of(:baths).only_integer.is_less_than_or_equal_to(4).is_greater_than_or_equal_to(1) }
    it { is_expected.to validate_numericality_of(:square_meters).only_integer.is_less_than_or_equal_to(240).is_greater_than_or_equal_to(20) }
  end

  describe 'callbacks' do
    context '#set_lonlat!' do
      let(:property) { build :property }

      before { property.save! }

      it { expect(property.lonlat).to be_present }
    end
  end
end
