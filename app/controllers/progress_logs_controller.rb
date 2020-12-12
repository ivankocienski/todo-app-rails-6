class ProgressLogsController < ApplicationController
    def index
        @progress_logs = ProgressLog.all
    end

    def show
        @progress_log = ProgressLog.find(params[:id])

    rescue ActiveRecord::RecordNotFound
        flash[:error] = 'Could not find progress log with that ID'
        redirect_to progress_logs_path
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
end
