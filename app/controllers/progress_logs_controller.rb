class ProgressLogsController < ApplicationController
    before_action :set_navigation
    before_action :find_progress_log_from_param_id, only: %i[show]

    def index
        @progress_logs = ProgressLog.all
    end

    def show
    end

    def new
        @progress_log = ProgressLog.new
        @open_todo_items = TodoItem.where(completed: false)
    end

    def create
        @progress_log = ProgressLog.new(progress_log_params)
        @progress_log.save!

        flash[:info] = 'Progress has been logged!'
        redirect_to progress_logs_path

    rescue ActiveRecord::RecordInvalid
        flash.now[:error] = 'Did not save progress log'
        render 'new'
    end

    private

    def progress_log_params
        params.require(:progress_log).permit(:on_day, :description, :todo_item_id)
    end

    def set_navigation
        @navigation = :progress_logs
    end

    def find_progress_log_from_param_id
        @progress_log = ProgressLog.find(params[:id])
    end
end
