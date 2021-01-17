class AddAspirationIdToTodoLists < ActiveRecord::Migration[6.0]
    def change
        add_column :todo_lists, :aspiration_id, :integer
    end
end
