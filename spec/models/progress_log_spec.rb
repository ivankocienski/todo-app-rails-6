require 'rails_helper'

describe ProgressLog, type: :model do
    context 'on_day' do
        it 'is set to a date by default' do
            start_of_day = DateTime.new.beginning_of_day

            progress_log = ProgressLog.new
            expect(progress_log.on_day).to eq start_of_day
        end

        it 'can be set as a parameter' do
            epoch = DateTime.new(2000, 10, 5, 15, 30, 25)
            start_of_day = epoch.beginning_of_day

            progress_log = ProgressLog.new(on_day: start_of_day)
            expect(progress_log.on_day).to eq start_of_day
        end
    end

    context 'todo_item' do
        context 'when not set' do
            it 'saves okay' do
                params = {
                    on_day: DateTime.new.beginning_of_day,
                    description: 'A description of the progress that was done today in long form'
                }

                progress_log = ProgressLog.create(params)
                expect(progress_log).to be_valid
            end
        end

        context 'when set' do
            let(:todo_item) { FactoryBot.create(:todo_item) }

            context 'with valid todo_item' do
                it 'is okay' do
                    params = {
                        on_day: DateTime.new.beginning_of_day,
                        description: 'A description of the progress that was done today in long form',
                        todo_item_id: todo_item.id
                    }

                    progress_log = ProgressLog.create(params)
                    expect(progress_log).to be_valid
                end
            end

            context 'with invalid todo_item' do
                it 'is not okay' do
                    params = {
                        on_day: DateTime.new.beginning_of_day,
                        description: 'A description of the progress that was done today in long form',
                        todo_item_id: 1234
                    }

                    progress_log = ProgressLog.create(params)
                    expect(progress_log).not_to be_valid
                end
            end
        end
    end
end
