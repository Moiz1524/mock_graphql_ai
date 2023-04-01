require "generators/mock_graphql_ai/install_generator"
require "fileutils"

RSpec.describe MockGraphqlAi::Generators::InstallGenerator do
  def config_file_1
    "#{Rails.root}/app/controllers/graphql_mocks_controller.rb"    
  end

  def config_file_2
    "#{Rails.root}/app/controllers/concerns/mockable.rb"   
  end

  def config_file_3
    "#{Rails.root}/app/models/mock_graphql_response.rb"   
  end

  def config_file_4
    Dir["#{Rails.root}/db/migrate/*_mock_graphql_responses.rb"].first
  end
  
  def remove_config
    FileUtils.remove_file(config_file_1) if File.file?(config_file_1)
    FileUtils.remove_file(config_file_2) if File.file?(config_file_2)
    FileUtils.remove_file(config_file_3) if File.file?(config_file_3)
    FileUtils.remove_file(config_file_4) if File.file?(config_file_4)
  end

  before(:all) { remove_config }

  after(:all) { remove_config }

  it "should run the installer" do
    described_class.start
    expect(File.file?(config_file_1)).to be(true)
    expect(File.file?(config_file_2)).to be(true)
    expect(File.file?(config_file_3)).to be(true)
    expect(File.file?(config_file_4)).to be(true)
  end
end