# frozen_string_literal: true

require 'json'

module V1
  class Executors < Grape::API
    include V1Base
    resource :executors do
      desc 'Get all executors', headers: HEADERS_DOCS, http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') }
      ]
      get '/executors' do
        executors = Executor.all
        render_success(ExecutorBlueprint.render_as_json(executors))
      end
    end

    desc 'Return a single executor', headers: HEADERS_DOCS, http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
    ]
    params do
      requires :id, type: String, desc: 'Executor id'
    end
    get 'executors/:id' do
      executor = Executor.find(params[:id])
      render_success(ExecutorBlueprint.render_as_json(executor))
    end

    desc 'Create new executor', http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:unprocessable_entity], message: 'Detail error messages' }
    ]
    params do
      requires :name, type: String, desc: 'Executor name'
      optional :project_id, type: String, desc: 'Project ID'
      optional :task_id, type: String, desc: 'Task ID'
    end
    post 'executors' do
      executor = Executor.new(params)
      if executor.save
        render_success(ExecutorBlueprint.render_as_json(executor))
      else
        error = executor.errors.full_messages.join(', ')
        render_error(RESPONSE_CODE[:unprocessable_entity], error)
      end
    end

    desc 'Update executor', headers: HEADERS_DOCS, http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') },
      { code: RESPONSE_CODE[:unprocessable_entity], message: 'Validation error messages' },
      { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
    ]
    params do
      optional :name, type: String, desc: 'Executor name'
    end
    patch 'executors/:id' do
      executor = Executor.find(params[:id])
      if executor.update(params)
        render_success(ExecutorBlueprint.render_as_json(executor))
      else
        error = executor.errors.full_messages.join(', ')
        render_error(RESPONSE_CODE[:unprocessable_entity], error)
      end
    end

    desc 'Delete executor', headers: HEADERS_DOCS, http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:unauthorized], message: I18n.t('errors.session.invalid_token') }
    ]
    delete 'executors/:id' do
      executor = Executor.find(params[:id])
      executor.destroy
      render_success({})
    end
    # def permitted_params
    #   params.require(:executor).permit(:name) # #CHECK PARAMS
    # end
  end
end
