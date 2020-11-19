class CreateTodoLists < ActiveRecord::Migration[6.0]
    def change
        create_table :todo_lists do |t|
            t.string :title, allow_nil: false

            t.timestamps
        end
    end
end
