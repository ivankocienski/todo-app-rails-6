class ApplicationController < ActionController::Base

    before_action :default_navigation

    private

    def default_navigation
        @navigation = :home
    end
end
