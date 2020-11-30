class AspirationsController < ApplicationController
    def index
        @aspirations = Aspiration.all
    end
end
