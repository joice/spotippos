require 'rails_helper'

RSpec.describe Province, type: :model do
  describe '#validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:area) }
  end
end
