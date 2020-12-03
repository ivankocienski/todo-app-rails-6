class AspirationsController < ApplicationController
    def index
        @aspirations = Aspiration.all
    end

    def new
        @aspiration = Aspiration.new
    end

    def show
        @aspiration = Aspiration.find_by_id(params[:id])
    end

    def edit
        @aspiration = Aspiration.find_by_id(params[:id])
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

    def update
        @aspiration = Aspiration.find_by_id(params[:id])
        @aspiration.update! aspiration_params

        flash[:info] = 'Aspiration saved'
        redirect_to aspiration_path(@aspiration)

    rescue ActiveRecord::RecordInvalid
        flash.now[:error] = 'The aspiration was not saved'
        render 'edit'
    end

    def destroy
        @aspiration = Aspiration.find_by_id(params[:id])
        @aspiration.destroy

        flash[:info] = 'Aspiration has been deleted'
        redirect_to aspirations_path
    end

    private

    def aspiration_params
        params.require(:aspiration).permit(:title, :description)
    end

end
