class ProgressLog < ApplicationRecord
    belongs_to :todo_item, optional: true
    validate :todo_item_should_exist

    attribute :on_day, :datetime, default: -> { DateTime.new.at_beginning_of_day }
    validates :description, length: 50..1500

    def todo_item_should_exist
        return unless todo_item_id && todo_item_id_changed? && !TodoItem.exists?(todo_item_id)

        errors.add :todo_item_id, 'The todo_item could not be found'
    end
end