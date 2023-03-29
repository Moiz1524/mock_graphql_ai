require 'rails/generators'

module Generators
  class MockModule < Rails::Generators::Base
    source_root(File.expand_path('../generators/templates', __dir__))
  
    def copy_module_file
      copy_file("mockable.rb", "app/controllers/concerns/mockable.rb")    
    end  
  end
end