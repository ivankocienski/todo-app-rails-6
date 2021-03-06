class AspirationsController < ApplicationController
    before_action :setup_navigation
    before_action :find_aspiration_from_param_id, only: %i[show edit update destroy]

    def index
        @aspirations = Aspiration.all
    end

    def new
        @aspiration = Aspiration.new
    end

    def show; end

    def edit
        @todo_count = @aspiration.todo_lists.count
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
        @aspiration.update! aspiration_params

        flash[:info] = 'Aspiration saved'
        redirect_to aspiration_path(@aspiration)

    rescue ActiveRecord::RecordInvalid
        flash.now[:error] = 'The aspiration was not saved'
        render 'edit'
    end

    def destroy
        @aspiration.todo_lists.destroy_all if delete_all_todo_lists?
        @aspiration.destroy

        flash[:info] = 'Aspiration has been deleted'
        redirect_to aspirations_path
    end

    private

    def aspiration_params
        params.require(:aspiration).permit(:title, :description)
    end

    def setup_navigation
        @navigation = :aspirations
    end

    def find_aspiration_from_param_id
        @aspiration = Aspiration.find(params[:id])
    end

    def delete_all_todo_lists?
        params[:delete_all_todo_lists].to_i == 1
    end
end
