class TodoItem < ApplicationRecord
    validates :description, length: 2..1000

    belongs_to :todo_list
    has_many :progress_logs
end
