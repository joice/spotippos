require 'rails_helper'
require 'rake'

RSpec.describe 'Provinces' do
  before do
    Rake.application.rake_require 'tasks/provinces'
    Rake::Task.define_task(:environment)
  end

  describe '#create' do
    it 'should create 6 provinces' do
      expect do
        Rake::Task['provinces:create'].invoke
      end.to change(Province, :count).by(6)
    end
  end
end
