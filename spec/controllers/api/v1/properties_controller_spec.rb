require 'rails_helper'

RSpec.describe Api::V1::PropertiesController, type: :controller do
  let!(:properties) { create_list(:property, 10) }
  let(:property) { properties.first }

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

  describe 'GET #index' do
    before { get :index, format: :json }

    it { expect(assigns(:properties).count).to eq(10) }
    it { expect(assigns(:properties).first.id).to eq(property.id) }
  end

  describe 'GET #show' do
    context 'when the record exists' do
      before { get :show, params: { id: property, format: :json } }

      it { expect(response).to have_http_status(:success) }
      it { expect(assigns(:property)).to eq(property) }
    end

    context 'when the record does not exist' do
      before { get :show, params: { id: 999_999, format: :json } }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.body).to match(/Couldn't find Property/) }
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Property' do
        expect do
          post :create, params: { property: valid_attributes, format: :json }
        end.to change(Property, :count).by(1)
      end

      it 'assigns a newly created property as @property' do
        post :create, params: { property: valid_attributes, format: :json }

        expect(assigns(:property)).to be_a(Property)
        expect(assigns(:property)).to be_persisted
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      before { post :create, params: { property: invalid_attributes, format: :json } }

      it { expect(assigns(:property)).to be_nil }
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PATCH #update' do
    describe 'with valid attributes' do
      before { patch :update, params: { id: property, property: valid_attributes } }

      it { expect(property.reload.title).to eq('Imóvel código 34, com 4 quartos e 3 banheiros') }
      it { expect(assigns(:property)).to eq(property) }
      it { expect(response.body).to be_empty }
      it { expect(response).to have_http_status(:no_content) }
    end

    describe 'with invalid attributes' do
      before { patch :update, params: { id: property, property: invalid_attributes } }

      it { expect(property.reload.title).to_not eq('Imóvel código 34, com 4 quartos e 3 banheiros') }
      it { expect(assigns(:property)).to eq(property) }
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete property' do
      expect do
        delete :destroy, params: { id: property }
      end.to change(Property, :count).by(-1)
    end

    context 'returns http no_content' do
      before { delete :destroy, params: { id: property } }

      it { expect(response).to have_http_status(:no_content) }
    end
  end
end
