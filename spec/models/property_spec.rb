require 'rails_helper'

RSpec.describe Property, type: :model do
  describe '#validations' do
    it { is_expected.to validate_numericality_of(:x).only_integer.is_less_than_or_equal_to(1400).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:y).only_integer.is_less_than_or_equal_to(1000).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:beds).only_integer.is_less_than_or_equal_to(5).is_greater_than_or_equal_to(1) }
    it { is_expected.to validate_numericality_of(:baths).only_integer.is_less_than_or_equal_to(4).is_greater_than_or_equal_to(1) }
    it { is_expected.to validate_numericality_of(:square_meters).only_integer.is_less_than_or_equal_to(240).is_greater_than_or_equal_to(20) }
  end

  describe '.find_by_polygon' do
    let!(:property_1) { create(:property, x: 1257, y: 928) }
    let!(:property_2) { create(:property, x: 679,  y: 680) }
    let!(:property_3) { create(:property, x: 1051, y: 441) }
    let!(:property_4) { create(:property, x: 252,  y: 868) }
    let!(:property_5) { create(:property, x: 34,   y: 660) }
    let!(:property_6) { create(:property, x: 1363, y: 122) }
    let!(:property_7) { create(:property, x: 38,   y: 664) }
    let!(:property_8) { create(:property, x: 1201, y: 592) }
    let!(:property_9) { create(:property, x: 795,  y: 534) }
    let!(:property_10) { create(:property, x: 304, y: 225) }

    context 'finds properties that are within a polygon' do
      let!(:gode_params) { { ax: 0, ay: 1000, bx: 600, by: 500 } } # Gode boundaries
      let!(:ruja_params) { { ax: 400, ay: 1000, bx: 1100, by: 500 } } # Ruja boundaries

      it { expect(Property.find_by_polygon(gode_params).size).to eq(3) }
      it { expect(Property.find_by_polygon(gode_params)).to match_array([property_4, property_5, property_7]) }

      it { expect(Property.find_by_polygon(ruja_params).size).to eq(2) }
      it { expect(Property.find_by_polygon(ruja_params)).to match_array([property_2, property_9]) }
    end

    context 'finds properties that are within a polygon and paginate them' do
      let!(:gode_params) { { ax: 0, ay: 1000, bx: 600, by: 500, per_page: 1 } } # Gode boundaries
      let!(:ruja_params) { { ax: 400, ay: 1000, bx: 1100, by: 500, per_page: 1, page: 2 } } # Ruja boundaries

      it { expect(Property.find_by_polygon(gode_params).size).to eq(1) }
      it { expect(Property.find_by_polygon(gode_params)).to match_array(property_4) }

      it { expect(Property.find_by_polygon(ruja_params).size).to eq(1) }
      it { expect(Property.find_by_polygon(ruja_params)).to match_array(property_9) }
    end
  end

  describe 'callbacks' do
    context '#set_lonlat!' do
      let(:property) { build :property }

      before { property.save! }

      it { expect(property.lonlat).to be_present }
    end
  end
end
