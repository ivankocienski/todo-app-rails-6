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
end
