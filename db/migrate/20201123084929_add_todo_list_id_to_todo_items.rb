class AddTodoListIdToTodoItems < ActiveRecord::Migration[6.0]
    def change
      add_column :todo_items, :todo_list_id, :integer
    end
end
