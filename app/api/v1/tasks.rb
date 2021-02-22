# frozen_string_literal: true

require 'json'

module V1
  class Tasks < Grape::API
    include V1Base
    resource :tasks do
      desc 'Get all tasks', headers: HEADERS_DOCS, http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') }
      ]
      get '/tasks' do
        tasks = Task.all
        render_success(TaskBlueprint.render_as_json(tasks))
      end
    end

    desc 'Return a single task', headers: HEADERS_DOCS, http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
    ]
    params do
      requires :id, String, desc: 'Task ID'
    end

    get 'tasks/:id' do
      task = Task.find(params[:id])
      render_success(TaskBlueprint.render_as_json(task))
    end

    desc 'Create new task', http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:unprocessable_entity], message: 'Detail error messages' }
    ]
    params do
      requires :name, type: String, desc: 'Task name'
      requires :status, type: String, desc: 'Task status'
      requires :due_time, type: Date, desc: 'Task deadline'
      requires :project_id, type: Integer, desc: 'Which project this task belongs to'
      requires :executor_id, type: Integer, desc: 'Who is responsible for the execution'
      optional :description, type: String, desc: 'Task description'
    end
    post 'tasks' do
      task = Task.new(params)
      if task.save
        render_success(TaskBlueprint.render_as_json(task))
      else
        error = task.errors.full_messages.join(', ')
        render_error(RESPONSE_CODE[:unprocessable_entity], error)
      end
    end

    desc 'Update task', headers: HEADERS_DOCS, http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') },
      { code: RESPONSE_CODE[:unprocessable_entity], message: 'Validation error messages' },
      { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
    ]
    params do
      optional :name, type: String, desc: 'Task name'
      optional :status, type: String, desc: 'Task status'
      optional :due_time, type: Date, desc: 'Task deadline'
      optional :project_id, type: Integer, desc: 'Which project this task belongs to'
      optional :executor_id, type: Integer, desc: 'Who is responsible for the execution'
      optional :description, type: String, desc: 'Task description'
    end
    patch 'tasks/:id' do
      task = Task.find(params[:id])
      if task.update(params)
        render_success(TaskBlueprint.render_as_json(task))
      else
        error = task.errors.full_messages.join(', ')
        render_error(RESPONSE_CODE[:unprocessable_entity], error)
      end
    end

    desc 'Delete task', headers: HEADERS_DOCS, http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:unauthorized], message: I18n.t('errors.session.invalid_token') }
    ]
    delete 'tasks/:id' do
      task = Task.find(params[:id])
      task.destroy
      render_success({})
    end
  end
end
