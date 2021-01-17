class TodoList < ApplicationRecord
    validates :title, length: 2..200

    belongs_to :aspiration, required: false
    has_many :todo_items, dependent: :destroy

end
