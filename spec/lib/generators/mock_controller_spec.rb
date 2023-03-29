require "generators/mock_controller"
require "fileutils"

RSpec.describe Generators::MockController do
  def config_file
    "#{Rails.root}/app/controllers/graphql_mocks_controller.rb"    
  end
  
  def remove_config
    FileUtils.remove_file(config_file) if File.file?(config_file)    
  end

  before(:all) { remove_config }

  after(:all) { remove_config }

  it "should install the mock controller" do
    described_class.start
    expect(File.file?(config_file)).to be(true)
  end
end