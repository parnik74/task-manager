# frozen_string_literal: true

require 'json'

module V1
  class Projects < Grape::API
    include V1Base
    resource :projects do
      desc 'Get all projects', headers: HEADERS_DOCS, http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') }
      ]
      get do
        projects = Project.all
        render_success(ProjectBlueprint.render_as_json(projects))
      end
    end

    desc 'Return a single project', headers: HEADERS_DOCS, http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
    ]
    params do
      requires :id, type: String, desc: 'Project id'
    end
    route_param :id do
      get do
        project = Project.find(params[:id])
        render_success(ProjectBlueprint.render_as_json(project))
      end
    end

    desc 'Create new project', http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:unprocessable_entity], message: 'Detail error messages' }
    ]
    params do
      requires :name, type: String, desc: 'Project name'
      requires :status, type: String, desc: 'Project status'
      requires :owner, type: Integer, desc: 'ID of the person running the project'
      optional :description, type: String, desc: 'Project desc'
    end
    post do
      project = Project.new(params)
      if project.save
        render_success(ProjectBlueprint.render_as_json(project))
      else
        error = project.errors.full_messages.join(', ')
        render_error(RESPONSE_CODE[:unprocessable_entity], error)
      end
    end

    desc 'Update project', headers: HEADERS_DOCS, http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') },
      { code: RESPONSE_CODE[:unprocessable_entity], message: 'Validation error messages' },
      { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
    ]
    params do
      optional :name, type: String, desc: 'Project name'
      optional :description, type: String, desc: 'Project description'
      optional :status, type: String, desc: 'Project status'
      optional :owner, type: Integer, desc: 'ID of the person running the project'
    end
    route_param :id do
      patch do
        project = Project.find(params[:id])
        if project.update(params)
          render_success(ProjectBlueprint.render_as_json(project))
        else
          error = project.errors.full_messages.join(', ')
          render_error(RESPONSE_CODE[:unprocessable_entity], error)
        end
      end
    end

    desc 'Delete project', headers: HEADERS_DOCS, http_codes: [
      { code: 200, message: 'success' },
      { code: RESPONSE_CODE[:unauthorized], message: I18n.t('errors.session.invalid_token') }
    ]
    route_param :id do
      delete do
        project = Project.find(params[:id])
        project.destroy
        render_success({})
      end
    end
  end
end
