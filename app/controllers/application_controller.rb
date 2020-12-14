class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, with: :respond_not_found

    before_action :default_navigation

    private

    def default_navigation
        @navigation = :home
    end

    def respond_not_found(problem = nil)
        @description = problem ? problem.to_s : nil
        render 'common/404', status: 404
    end
end
