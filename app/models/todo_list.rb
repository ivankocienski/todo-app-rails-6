class TodoList < ApplicationRecord
    validates :title, length: 2..200

    belongs_to :aspiration, required: false
    validate :aspiration_should_exist

    has_many :todo_items, dependent: :destroy

    def aspiration_should_exist
        return unless aspiration_id && aspiration_id_changed? && !Aspiration.exists?(aspiration_id)

        errors.add :aspiration_id, 'The Aspiration could not be found'
    end
end
