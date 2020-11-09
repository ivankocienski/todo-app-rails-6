class TodoItemsController < ApplicationController

    def index
        @items = TodoItem.all
    end

    def new
        @item = TodoItem.new
    end

    def create
        @item = TodoItem.create!(item_params)
        
        redirect_to todo_items_path

    rescue ActiveRecord::RecordInvalid

        render 'new'
    end

private

    def item_params
        params.require(:todo_item).permit(:description)
    end
end
