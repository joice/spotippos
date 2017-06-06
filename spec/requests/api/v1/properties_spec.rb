require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  let!(:jaby) { create(:province, name: 'Jaby', area: 'POLYGON((1100 1000, 1400 1000, 1400 500, 1100 500, 1100 1000))') }
  let!(:gode) { create(:province, name: 'Gode', area: 'POLYGON((0 1000, 600 1000, 600 500, 0 500, 0 1000))') }
  let!(:ruja) { create(:province, name: 'Ruja', area: 'POLYGON((400 1000, 1100 1000, 1100 500, 400 500, 400 1000))') }
  let!(:scavy) { create(:province, name: 'Scavy', area: 'POLYGON((0 500, 600 500, 600 0, 0 0, 0 500))') }
  let!(:nova) { create(:province, name: 'Nova', area: 'POLYGON((800 500, 1400 500, 1400 0, 800 0, 800 500))') }

  let!(:property_1) { create(:property, x: 1257, y: 928, provinces: [jaby]) }
  let!(:property_2) { create(:property, x: 679,  y: 680, provinces: [ruja]) }
  let!(:property_3) { create(:property, x: 1051, y: 441, provinces: [nova]) }
  let!(:property_4) { create(:property, x: 252,  y: 868, provinces: [gode]) }
  let!(:property_5) { create(:property, x: 34,   y: 660, provinces: [gode]) }
  let!(:property_6) { create(:property, x: 1363, y: 122, provinces: [nova]) }
  let!(:property_7) { create(:property, x: 38,   y: 664, provinces: [gode]) }
  let!(:property_8) { create(:property, x: 1201, y: 592, provinces: [jaby]) }
  let!(:property_9) { create(:property, x: 795,  y: 534, provinces: [ruja]) }
  let!(:property_10) { create(:property, x: 304, y: 225, provinces: [scavy]) }

  let(:valid_attributes) do
    { title: 'Imóvel código 34, com 4 quartos e 3 banheiros',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      price: 1_250_000,
      x: 999,
      y: 333,
      beds: 4,
      baths: 3,
      square_meters: 237 }
  end

  let(:invalid_attributes) do
    { title: 'Imóvel código 34, com 4 quartos e 3 banheiros',
      price: 1_250_000,
      x: 0,
      y: 0,
      beds: 0,
      baths: 0,
      square_meters: 237 }
  end

  describe 'GET /api/v1/properties' do
    before { get api_v1_properties_path, params: { ax: 0, ay: 1000, bx: 600, by: 500 } } # Gode boundaries

    it 'returns a list of properties', :show_in_doc do
      expect(json).not_to be_empty
      expect(json['properties'].size).to eq(3)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/v1/property/:id' do
    context 'when the record exists' do
      before { get api_v1_property_path(property_1) }

      it 'returns the property', :show_in_doc do
        expect(json).not_to be_empty
        expect(json['id']).to eq(property_1.id)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the record does not exist' do
      let(:property_id) { 100 }
      before { get api_v1_property_path(id: property_id) }

      it 'returns http not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Property/)
      end
    end
  end

  describe 'POST /api/v1/properties' do
    context 'when the request is valid' do
      before { post api_v1_properties_path, params: { property: valid_attributes } }

      it 'creates a property', :show_in_doc do
        expect(json['title']).to eq('Imóvel código 34, com 4 quartos e 3 banheiros')
        expect(json['price']).to eq(1_250_000)
        expect(json['x']).to eq(999)
        expect(json['y']).to eq(333)
        expect(json['beds']).to eq(4)
        expect(json['baths']).to eq(3)
        expect(json['square_meters']).to eq(237)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_properties_path, params: { property: invalid_attributes } }

      it 'returns http unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Beds must be greater than or equal to 1, Baths must be greater than or equal to 1/)
      end
    end
  end

  describe 'PATCH /api/v1/properties/:id' do
    context 'when the record exists' do
      before { patch api_v1_property_path(property_1), params: { property: valid_attributes } }

      it 'updates the record', :show_in_doc do
        expect(response.body).to be_empty
      end

      it 'returns http no_content' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'DELETE /properties/:id', :show_in_doc do
    before { delete api_v1_property_path(property_1) }

    it 'returns http no_content' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
