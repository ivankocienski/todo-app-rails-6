class TodoItemsController < ApplicationController

    def index
        @items = TodoItem.all
    end
end
