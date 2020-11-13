class HomeController < ApplicationController
    def root
    end

    def about
        @navigation = :about
    end
end
