class TodoListsController < ApplicationController
    def index
        @todo_lists = TodoList.all
    end

    def new
        @todo_list = TodoList.new
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

    private

    def todo_list_params
        params.require(:todo_list).permit(:title)
    end
end
