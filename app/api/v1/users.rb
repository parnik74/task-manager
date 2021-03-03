# frozen_string_literal: true

require 'json'

module V1
  class Users < Grape::API
    # include V1Base
    resource :users do
      desc 'Get all users', http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') }
      ]
      get do
        users = User.all
        render_success(UserBlueprint.render_as_json(users))
      end
    end

    desc 'Return a single user', http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
    ]
    params do
      requires :id, type: String, desc: 'User id'
    end
    route_param :id do
      get do
        user = User.find(params[:id])
        render_success(UserBlueprint.render_as_json(user))
      end
    end

    desc 'Create new user', http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:unprocessable_entity], message: 'Detail error messages' }
    ]
    params do
      requires :name, type: String, desc: 'User name'
      optional :project_id, type: String, desc: 'Project ID'
      optional :task_id, type: String, desc: 'Task ID'
    end
    post do
      user = User.new(params)
      if user.save
        render_success(UserBlueprint.render_as_json(user))
      else
        error = user.errors.full_messages.join(', ')
        render_error(RESPONSE_CODE[:unprocessable_entity], error)
      end
    end

    desc 'Update user', http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') },
      { code: RESPONSE_CODE[:unprocessable_entity], message: 'Validation error messages' },
      { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
    ]
    params do
      optional :name, type: String, desc: 'User name'
    end
    route_param :id do
      patch do
        user = User.find(params[:id])
        if user.update(params)
          render_success(UserBlueprint.render_as_json(user))
        else
          error = user.errors.full_messages.join(', ')
          render_error(RESPONSE_CODE[:unprocessable_entity], error)
        end
      end
    end

    desc 'Delete user', http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:unauthorized], message: I18n.t('errors.session.invalid_token') }
    ]
    route_param :id do
      delete do
        user = User.find(params[:id])
        user.destroy
        render_success({})
      end
    end
  end
end
