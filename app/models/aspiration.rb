class Aspiration < ApplicationRecord
    validates_length_of :title, within: 5..200
    has_many :todo_lists, dependent: :nullify
end
