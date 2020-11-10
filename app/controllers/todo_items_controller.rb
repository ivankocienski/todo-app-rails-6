class TodoItemsController < ApplicationController

    def index
        @filter_items = params[:filter] || ''
        @filter_items = @filter_items == 'pending'

        if @filter_items
            @items = TodoItem.where(completed: false).all
        else 
            @items = TodoItem.all
        end
    end

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
        @item = TodoItem.create!(item_params)
        
        redirect_to todo_items_path

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
        redirect_to todo_items_path
    end

private

    def item_params
        params.require(:todo_item).permit(:description)
    end

    #def filter_completed
    #end
end
