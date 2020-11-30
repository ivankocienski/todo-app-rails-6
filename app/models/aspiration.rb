class Aspiration < ApplicationRecord
    validates_length_of :title, within: 5..200
end
