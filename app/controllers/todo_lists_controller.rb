class TodoListsController < ApplicationController
    before_action :setup_navigation
    before_action :find_todo_list, only: %i[show edit update destroy]

    def index
        @todo_lists = TodoList.all
    end

    def new
        @todo_list = TodoList.new
        @aspirations = Aspiration.order(:title).all
    end

    def show
        @show_only_pending = filter_param

        @todo_items = if @show_only_pending
                          @todo_list.todo_items.where(completed: false)
                      else
                          @todo_list.todo_items
                      end
    end

    def edit
        @aspirations = Aspiration.order(:title).all
    end

    def create
        @todo_list = TodoList.new(todo_list_params)
        @todo_list.save!

        flash[:info] = 'Todo List has been created'
        redirect_to todo_index_path

    rescue ActiveRecord::RecordInvalid
        flash.now[:error] = 'Todo List was not saved'
        render 'new'
    end

    def update
        @todo_list.update! todo_list_params

        flash[:info] = 'Todo List updated successfully'
        redirect_to todo_index_path

    rescue ActiveRecord::RecordInvalid
        flash.now[:error] = 'Todo List failed to update'
        render 'edit'
    end

    def destroy
        @todo_list.destroy

        redirect_to todo_index_path
        flash[:info] = 'Todo List has been deleted'
    end

    private

    def setup_navigation
        @navigation = :todo_lists
    end

    def filter_param
        (params[:filter] || '') == 'pending'
    end

    def todo_list_params
        params.require(:todo_list).permit(:title, :aspiration_id)
    end

    def find_todo_list
        @todo_list = TodoList.find(params[:id])
    end
end
