# frozen_string_literal: true

require 'grape-swagger'

module V1
  class Base < Grape::API
    mount V1::Projects
    mount V1::Tasks
    mount V1::Executors

    add_swagger_documentation(
      api_version: 'v1',
      hide_documentation_path: true,
      mount_path: '/api/v1/swagger_doc',
      hide_format: true
    )
  end
end
