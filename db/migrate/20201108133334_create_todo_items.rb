class CreateTodoItems < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_items do |t|
      t.text :description, default: '', allownil: false
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
