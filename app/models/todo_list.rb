class TodoList < ApplicationRecord
    validates :title, length: 2..200
end
