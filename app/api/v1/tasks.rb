# frozen_string_literal: true

require 'json'

module V1
  class Tasks < Grape::API
    resource :tasks do
      desc 'Get all tasks', http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') }
      ]
      get do
        # tasks = Task.all
        tasks = policy_scope(Task)
        render_success(TaskBlueprint.render_as_json(tasks))
      end

      desc 'Create new task', http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:unprocessable_entity], message: 'Detail error messages' }
      ]
      params do
        requires :name, type: String, desc: 'Task name'
        requires :status, type: String, desc: 'Task status'
        optional :due_time, type: Date, desc: 'Task deadline'
        requires :project_id, type: Integer, desc: 'Which project this task belongs to'
        requires :assignee_id, type: Integer, desc: 'Who is responsible for the execution'
        optional :description, type: String, desc: 'Task description'
      end
      post do
        task = Task.new(params)
        if task.save
          render_success(TaskBlueprint.render_as_json(task))
        else
          error = task.errors.full_messages.join(', ')
          render_error(RESPONSE_CODE[:unprocessable_entity], error)
        end
      end

      route_param :id do
        helpers do
          def resource_task
            @resource_task ||= Task.find(params[:id])
          end
        end
        desc 'Return a single task', http_codes: [
          { code: 200, message: 'success' },
          { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
        ]
        params do
          requires :id, type: String, desc: 'Task id'
        end
        get do
          authorize resource_task, :show?, policy_class: TaskPolicy
          render_success(TaskBlueprint.render_as_json(resource_task))
        end

        desc 'Update task', http_codes: [
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
          optional :assignee_id, type: Integer, desc: 'Who is responsible for the execution'
          optional :description, type: String, desc: 'Task description'
          optional :deleted_at, type: DateTime, desc: 'Change to null to restore task from deleted'
        end

        patch do
          authorize resource_task, :update?, policy_class: TaskPolicy
          if resource_task.update(params)
            render_success(TaskBlueprint.render_as_json(resource_task))
          else
            error = resource_task.errors.full_messages.join(', ')
            render_error(RESPONSE_CODE[:unprocessable_entity], error)
          end
        end

        desc 'Delete task', http_codes: [
          { code: 200, message: 'success' },
          { code: RESPONSE_CODE[:unauthorized], message: I18n.t('errors.session.invalid_token') }
        ]

        delete do
          authorize resource_task, :destroy?, policy_class: TaskPolicy
          resource_task.soft_delete
          render_success({})
        end
      end
    end
  end
end
