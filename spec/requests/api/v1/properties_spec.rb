require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  let!(:properties) { create_list(:property, 10) }
  let(:property) { properties.first }

  describe 'GET /api/v1/properties' do
    before { get api_v1_properties_path, params: { format: :json } }

    it 'returns a list of properties' do
      expect(json).not_to be_empty
      expect(json['properties'].size).to eq(10)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/v1/property/:id' do
    context 'when the record exists' do
      before { get api_v1_property_path(property), params: { format: :json } }

      it 'returns the property' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(property.id)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:property_id) { 100 }
      before { get api_v1_property_path(id: property_id), params: { format: :json } }

      it 'returns http not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Property/)
      end
    end
  end
end
