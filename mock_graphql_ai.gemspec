require File.expand_path('lib/mock_graphql_ai/version', __dir__)

Gem::Specification.new do |spec|
  spec.name = 'mock_graphql_ai'
  spec.version = MockGraphqlAi::VERSION
  spec.authors= ['Moiz Ali']
  spec.email = ['amoiz4142@gmail.com']
  spec.summary = "A thin wrapper to generate mock GraphQL API responses via OpenAI gpt-3.5-turbo in Ruby apps."
  spec.homepage = 'https://github.com/Moiz1524/mock_graphql_ai'
  spec.license = 'MIT'
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.6.0'

  spec.files = Dir['README.md', 'LICENSE', 'CHANGELOG.md', 'lib/**/*.rb',
                   'lib/**/*.rake', 'mock_graphql_ai.gemspec', '.github/*.md',
                   'Gemfile', 'Rakefile']
  spec.extra_rdoc_files = ['README.md']

  # spec.add_runtime_dependency 'graphql', '~> 2.0', '>= 2.0.19'
  spec.add_runtime_dependency 'ruby-openai', '~> 0.1.0'

  spec.add_development_dependency 'rubocop', '~> 1.48', '>= 1.48.1'
  spec.add_development_dependency 'rubocop-performance', '~> 1.16'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.19'
end