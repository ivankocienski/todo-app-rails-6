class CreateProgressLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :progress_logs do |t|
      t.datetime :on_day
      t.text :description

      t.timestamps
    end
  end
end
