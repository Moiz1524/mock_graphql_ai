# MockGraphqlAI

![openai-gpt-3.5-turbo](https://img.shields.io/badge/openai-gpt--3.5--turbo-orange)
![graphql-dev](https://img.shields.io/badge/graphql-dev-blueviolet)
![rubocop-dev](https://img.shields.io/badge/rubocop-dev-ff69b4)
![rspec-dev](https://img.shields.io/badge/rspec-dev-success)
![rails-dev](https://img.shields.io/badge/rails-dev-red)

Residing on Server Side, there's always a need to be one step ahead to provide APIs for client side teams to consume. To enable seamless development and parallel processing. Here comes a thin wrapper to generate mock GraphQL API responses via OpenAI gpt-3.5-turbo in Ruby apps.

When Real APIs are ready, tweak the configuration. Its minimal :heart:

## Getting Started

### Pre-requisites

It is built over OpenAI's ruby library i.e., `ruby-openai`. Make sure to follow through [here](https://github.com/alexrudall/ruby-openai). You can check the graphql-ruby documentation [here](https://graphql-ruby.org/) as well

### Install

Add this to your Gemfile

```ruby
gem 'mock_graphql_ai', '~> 1.1'
```

Run `bundle install`

### Invoke Generator

In order to add mock files you have to run install generator

```ruby
rails g mock_graphql_ai:install
```
It'll do the following changes:

- Add a module named `mockable` in `app/controllers/concerns`
- Add a controller named `graphql_mocks_controller` to bypass graphql-ruby original controller
- Add a model named `MockGraphqlResponse` to persist responses inside db for repititions. Saving the OpenAI overhead
- Add the respective migration for model with attributes
- Add a mock route inside `routes.rb`

```ruby
  get '/imitate_graphql', to: 'graphql_mocks#imitate', as: :imitate_graphql
```

**Note**: *You can extend the model layer but remember to keep the original configuration intact, super essential for gem to work properly for now*

### Enable Mockers :fire:

Include mockable module inside `graphql_controller` and add a before filter to bypass the `#execute`

```ruby
class GraphqlController < ApplicationController
  include Mockable
  
  before_action :bypass_graphql, only: [:execute] if Rails.env.development?
  
  def execute
    # Your normal code goes here ...
  end
end
```
If you notice the code inside `graphql_mocks_controller` there is a simple API call to service that generates the responses and persist them for future use

```ruby
class GraphqlMocksController < ApplicationController
  def imitate
    result = MockGraphqlAi::Resource.new(
      query: params[:query],
      token: Rails.application.credentials.dig(:openai, :access_token) # Your ENV var
    ).respond!

    render json: result
  end 
end
```


### Requirements

This gem requires Ruby 2.6+
Also it requires [graphql]('https://github.com/rmosolgo/graphql-ruby') to override its ability to generate responses. Rails 6.x or plus recommended
