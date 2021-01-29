require 'rails_helper'

describe TodoItemsHelper, type: :helper do
    context '#todo_item_title_status' do
        it 'returns basic text for non-completed item' do
            item = FactoryBot.build(:todo_item)
            title = todo_item_title_status(item)

            expect(title).to eq item.description
        end

        it 'returns description and done status flag on completed items' do
            item = FactoryBot.build(:todo_item, completed: true)
            title = todo_item_title_status(item)

            expect(title).to eq("#{item.description} (done)")
        end
    end

    context '#aspiration_options' do
        it 'returns list of aspirations options' do
            aspirations = [
                FactoryBot.build(:aspiration),
                FactoryBot.build(:aspiration_2),
                FactoryBot.build(:aspiration_3)
            ]

            output = aspiration_options(aspirations)
            expect(output).to be_a(Array)
            expect(output.length).to eq 4
        end
    end
end