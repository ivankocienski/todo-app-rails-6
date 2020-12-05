class ProgressLog < ApplicationRecord
    attribute :on_day, :datetime, default: -> { DateTime.new.at_beginning_of_day }
    validates :description, length: 50..1500
end
