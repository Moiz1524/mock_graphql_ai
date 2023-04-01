require "generators/mock_graphql_ai/install_generator"
require "fileutils"

RSpec.describe MockGraphqlAi::Generators::InstallGenerator do
  def files_path
    [
      "#{Rails.root}/app/controllers/graphql_mocks_controller.rb",
      "#{Rails.root}/app/controllers/concerns/mockable.rb",
      "#{Rails.root}/app/models/mock_graphql_response.rb",
      Dir["#{Rails.root}/db/migrate/*_mock_graphql_responses.rb"].first 
    ]
  end
  
  def remove_config
    files_path.each { |path| FileUtils.remove_file(path) if File.file?(path) }
  end

  before(:all) { remove_config }

  after(:all) { remove_config }

  it "should run the installer" do
    described_class.start
    files_path.each { |path| expect(File.file?(path)).to be(true) }
  end
end