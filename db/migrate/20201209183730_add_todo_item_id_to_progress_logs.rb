class AddTodoItemIdToProgressLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :progress_logs, :todo_item_id, :integer
  end
end
