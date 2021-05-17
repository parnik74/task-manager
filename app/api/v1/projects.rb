# frozen_string_literal: true

require 'json'

module V1
  class Projects < Grape::API
    resource :projects do
      desc 'Get all projects', http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') }
      ]
      get do
        # projects = Project.all
        # authorize Project, :get?
        projects = policy_scope(Project)

        render_success(ProjectBlueprint.render_as_json(projects))
      end

      desc 'Create new project', http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:unprocessable_entity], message: 'Detail error messages' }
      ]
      params do
        requires :name, type: String, desc: 'Project name'
        requires :status, type: String, desc: 'Project status'
        # requires :owner_id, type: Integer, desc: 'ID of the person running the project'
        optional :description, type: String, desc: 'Project desc'
      end
      post do
        project = Project.new(params)
        project.owner_id = current_user
        authorize project
        if project.save
          render_success(ProjectBlueprint.render_as_json(project))
        else
          error = project.errors.full_messages.join(', ')
          render_error(RESPONSE_CODE[:unprocessable_entity], error)
        end
      end

      route_param :id do
        helpers do
          def resource_project
            @resource_project ||= Project.find(params[:id])
            authorize @resource_project # <=====PUNDIT
          end

          def soft_delete(object)
            object.update(object.deleted_at = Time.current)
          end
        end
        desc 'Return a single project', http_codes: [
          { code: 200, message: 'success' },
          { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
        ]
        params do
          requires :id, type: String, desc: 'Project id'
        end
        get do
          render_success(ProjectBlueprint.render_as_json(resource_project))
        end

        desc 'Update project', http_codes: [
          { code: 200, message: 'success' },
          { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') },
          { code: RESPONSE_CODE[:unprocessable_entity], message: 'Validation error messages' },
          { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
        ]
        params do
          optional :name, type: String, desc: 'Project name'
          optional :description, type: String, desc: 'Project description'
          optional :status, type: String, desc: 'Project status'
          optional :owner_id, type: Integer, desc: 'ID of the person running the project'
          optional :deleted_at, type: DateTime, desc: 'Change to null to restore project from deleted'
        end
        patch do
          if resource_project.update(params)
            render_success(ProjectBlueprint.render_as_json(resource_project))
          else
            error = resource_project.errors.full_messages.join(', ')
            render_error(RESPONSE_CODE[:unprocessable_entity], error)
          end
        end

        desc 'Delete project', http_codes: [
          { code: 200, message: 'success' },
          { code: RESPONSE_CODE[:unauthorized], message: I18n.t('errors.session.invalid_token') }
        ]
        delete do
          resource_project.soft_delete
          render_success({})
        end
      end
    end
  end
end
