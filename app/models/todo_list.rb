class TodoList < ApplicationRecord
    validates :title, length: 2..200

    has_many :todo_items, dependent: :destroy
end
