class TodoListsController < ApplicationController
    def index
        @todo_lists = TodoList.all
    end

    def new
        @todo_list = TodoList.new
    end

    def show
        @todo_list = TodoList.find_by_id(params[:id])
        if @todo_list.nil?
            flash[:error] = 'Could not find a Todo List with that ID'
            redirect_to todo_lists_path
        end
    end

    def edit
        @todo_list = TodoList.find_by_id(params[:id])
        if @todo_list.nil?
            flash[:error] = 'Could not find a Todo List with that ID'
            redirect_to todo_lists_path
        end
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
        @todo_list = TodoList.find_by_id(params[:id])
        if @todo_list.nil?
            flash[:error] = 'Could not find a Todo List with that ID'

        else
            flash[:info] = 'Todo List updated successfully'
            @todo_list.update! todo_list_params
        end

        redirect_to todo_lists_path

    rescue ActiveRecord::RecordInvalid
        flash.now[:error] = 'Todo List failed to update'
        render 'edit'
    end

    private

    def todo_list_params
        params.require(:todo_list).permit(:title)
    end
end
