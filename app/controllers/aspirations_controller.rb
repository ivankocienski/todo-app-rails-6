class AspirationsController < ApplicationController
    def index
        @aspirations = Aspiration.all
    end

    def new
        @aspiration = Aspiration.new
    end

    def create
        @aspiration = Aspiration.new(aspiration_params)
        @aspiration.save!

        flash[:info] = 'Aspiration created'
        redirect_to aspirations_path

    rescue ActiveRecord::RecordInvalid
        flash.now[:error] = 'The aspiration was not saved'
        render 'new'
    end

    private

    def aspiration_params
        params.require(:aspiration).permit(:title, :description)
    end

end
