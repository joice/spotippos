require 'rails_helper'
require 'rake'

RSpec.describe 'Properties' do
  before do
    Rake.application.rake_require 'tasks/properties'
    Rake::Task.define_task(:environment)
  end

  describe '#create' do
    it 'should create 6 properties' do
      expect do
        Rake::Task['properties:create'].invoke
      end.to change(Property, :count).by(8000)
    end
  end
end
