require 'rails_helper'

RSpec.describe Api::V1::PropertiesController, type: :controller do
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
    context 'without pass page and per_page params' do
      before { get :index, params: { ax: 0, ay: 1000, bx: 600, by: 500, format: :json } } # Gode boundaries

      it { expect(assigns(:properties).count).to eq(3) }
    end

    context 'passing per_page params' do
      before { get :index, params: { ax: 0, ay: 1000, bx: 600, by: 500, per_page: 1, format: :json } } # Gode boundaries

      it { expect(assigns(:total_pages)).to eq(3) }
      it { expect(assigns(:properties).count).to eq(1) }
      it { expect(assigns(:properties).first.id).to eq(property_4.id) }
    end

    context 'passing per_page and page params' do
      before { get :index, params: { ax: 0, ay: 1000, bx: 600, by: 500, per_page: 1, page: 3, format: :json } } # Gode boundaries

      it { expect(assigns(:total_pages)).to eq(3) }
      it { expect(assigns(:properties).count).to eq(1) }
      it { expect(assigns(:properties).first.id).to_not eq(property_4.id) }
      it { expect(assigns(:properties).first.id).to eq(property_7.id) }
    end
  end

  describe 'GET #show' do
    context 'when the record exists' do
      before { get :show, params: { id: property_1, format: :json } }

      it { expect(response).to have_http_status(:success) }
      it { expect(assigns(:property)).to eq(property_1) }
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
      before { patch :update, params: { id: property_1, property: valid_attributes } }

      it { expect(property_1.reload.title).to eq('Imóvel código 34, com 4 quartos e 3 banheiros') }
      it { expect(assigns(:property)).to eq(property_1) }
      it { expect(response.body).to be_empty }
      it { expect(response).to have_http_status(:no_content) }
    end

    describe 'with invalid attributes' do
      before { patch :update, params: { id: property_1, property: invalid_attributes } }

      it { expect(property_1.reload.title).to_not eq('Imóvel código 34, com 4 quartos e 3 banheiros') }
      it { expect(assigns(:property)).to eq(property_1) }
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete property' do
      expect do
        delete :destroy, params: { id: property_1 }
      end.to change(Property, :count).by(-1)
    end

    context 'returns http no_content' do
      before { delete :destroy, params: { id: property_1 } }

      it { expect(response).to have_http_status(:no_content) }
    end
  end
end
