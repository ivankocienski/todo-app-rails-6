class TodoItemsController < ApplicationController
    before_action :set_navigation_mode
    before_action :find_todo_list

    def new
        @item = TodoItem.new
    end

    def edit
        @item = TodoItem.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash.now[:error] = 'Todo Item not found'
        @item = TodoItem.new
        render 'edit', status: 404
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
        @item = TodoItem.find(params[:id])
        @item.update! completed: true

        flash[:info] = 'Item marked as completed'
    rescue ActiveRecord::RecordNotFound
        flash[:error] = 'Todo Item with that ID could not be found'
    ensure
        redirect_to todo_list_path(@todo_list)
    end

    private

    def item_params
        params.require(:todo_item).permit(:description)
    end

    def set_navigation_mode
        @navigation = :todo_items
    end

    def find_todo_list
        @todo_list = TodoList.find_by_id(params[:todo_list_id])
        return if @todo_list

        flash[:error] = 'Could not find Todo List with that ID'
        redirect_to todo_lists_path
    end
end
