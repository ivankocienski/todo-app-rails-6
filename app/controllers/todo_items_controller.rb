class TodoItemsController < ApplicationController
    before_action :set_navigation_mode
    before_action :find_todo_list_from_param
    before_action :find_todo_item_from_param, only: %i[show edit update]

    def show
        @progress_logs = @item.progress_logs
    end

    def new
        @item = TodoItem.new
    end

    def edit
        @item = TodoItem.find(params[:id])
    end

    def create
        @item = TodoItem.new(item_params)
        @item.todo_list = @todo_list
        @item.save!

        redirect_to todo_list_path(@todo_list)

    rescue ActiveRecord::RecordInvalid
        render 'new'
    end

    def update
        @item.update! completed: true

        flash[:info] = 'Item marked as completed'

    ensure
        redirect_to todo_list_path(@todo_list)
    end

    private

    def item_params
        params.require(:todo_item).permit(:description)
    end

    def set_navigation_mode
        @navigation = :todo_lists
    end

    def find_todo_list_from_param
        @todo_list = TodoList.find(params[:todo_list_id])
    end

    def find_todo_item_from_param
        @item = @todo_list.todo_items.find(params[:id])
    end
end
