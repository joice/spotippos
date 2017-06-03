require 'rails_helper'

RSpec.describe Api::V1::PropertiesController, type: :controller do
  let!(:properties) { create_list(:property, 10) }
  let(:property) { properties.first }

  describe 'GET index' do
    before { get :index, format: :json }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of properties' do
      expect(assigns(:properties)).to include(property)
    end
  end

  describe 'GET show' do
    context 'when the record exists' do
      before { get :show, params: { id: property.to_param, format: :json } }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the property' do
        expect(assigns(:property)).to eq(property)
      end
    end

    context 'when the record does not exist' do
      before { get :show, params: { id: 999999, format: :json } }

      it 'returns http not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Property/)
      end
    end
  end
end
