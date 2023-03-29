require "generators/mock_module"
require "fileutils"

RSpec.describe Generators::MockModule do
  def config_file
    "#{Rails.root}/app/controllers/concerns/mockable.rb"
  end

  def remove_config
    FileUtils.remove_file(config_file) if File.file?(config_file)    
  end

  before(:all) { remove_config }

  after(:all) { remove_config }

  it "should install the module file" do
    described_class.start
    expect(File.file?(config_file)).to be(true)
  end
end
