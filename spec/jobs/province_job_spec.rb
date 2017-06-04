require 'rails_helper'

RSpec.describe ProvinceJob, type: :job do
  let!(:property) { create(:property, x: 1257, y: 928) }
  let!(:province_1) { create(:province, name: 'Jaby', area: 'POLYGON((1100 1000, 1400 1000, 1400 500, 1100 500, 1100 1000))') }
  let!(:province_2) { create(:province, name: 'Gode', area: 'POLYGON((0 1000, 600 1000, 600 500, 0 500, 0 1000))') }

  it 'should have enqueue job' do
    expect do
      ProvinceJob.perform_later(property_id: property.id)
    end.to have_enqueued_job(ProvinceJob)
  end

  it 'should have create provinces to property' do
    expect do
      ProvinceJob.perform_now(property_id: property.id)
    end.to change { property.reload.provinces.size }.by(1)
  end

  context 'should set Jaby as province ' do
    before do
      ProvinceJob.perform_now(property_id: property.id)
    end

    it { expect(property.reload.province_ids).to contain_exactly(province_1.id) }
    it { expect(property.reload.province_ids).to_not match_array([province_2.id]) }
  end
end
