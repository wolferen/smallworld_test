require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s


  config.swagger_docs = {
    'v1/swagger.yaml' => {
      swagger: '2.0',
      info: {
        title: 'test API',
        version: 'v1'
      },
      paths: {}
    }
  }

  config.swagger_format = :yaml
end
