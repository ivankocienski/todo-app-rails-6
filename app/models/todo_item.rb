class TodoItem < ApplicationRecord
    validates :description, length: 2..1000
end
