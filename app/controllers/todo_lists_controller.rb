class TodoListsController < ApplicationController
    before_action :find_todo_list, only: %i[show edit update destroy]

    def index
        @todo_lists = TodoList.all
    end

    def new
        @todo_list = TodoList.new
    end

    def show
        @todo_items = @todo_list.todo_items.all
    end

    def edit
    end

    def create
        @todo_list = TodoList.new(todo_list_params)
        @todo_list.save!

        flash[:info] = 'Todo List has been created'
        redirect_to todo_lists_path

    rescue ActiveRecord::RecordInvalid
        flash.now[:error] = 'Todo List was not saved'
        render 'new'
    end

    def update
        @todo_list.update! todo_list_params

        flash[:info] = 'Todo List updated successfully'
        redirect_to todo_lists_path

    rescue ActiveRecord::RecordInvalid
        flash.now[:error] = 'Todo List failed to update'
        render 'edit'
    end

    def destroy
        @todo_list.destroy

        redirect_to todo_lists_path
        flash[:info] = 'Todo List has been deleted'
    end

    private

    def todo_list_params
        params.require(:todo_list).permit(:title)
    end

    def find_todo_list
        @todo_list = TodoList.find_by_id(params[:id])
        return if @todo_list

        flash[:error] = 'Could not find a Todo List with that ID'
        redirect_to todo_lists_path
    end
end
