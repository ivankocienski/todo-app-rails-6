require 'rails_helper'

RSpec.describe TodoItem, type: :model do
    context 'basic' do
        it 'is valid' do
            contents = {
                description: 'This'
            }

            item = TodoItem.create(contents)
            expect(item).to be_valid
        end

        it 'is invalid' do
            item = TodoItem.create

            expect(item).not_to be_valid
        end
    end
end
