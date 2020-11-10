module TodoItemsHelper

    def todo_item_title_status(item)
        item.description + (item.completed ? " (done)" : '')
    end
end
