class HomeController < ApplicationController
    def root
        @aspirations = Aspiration.order(:title).all
        @todo_lists = TodoList.order(:title).all
    end

    def about
        @navigation = :about
    end
end
