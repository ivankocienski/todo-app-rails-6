require 'rails_helper'

RSpec.describe ProgressLogsHelper, type: :helper do
    context '#progress_log_on_day_s' do
        it 'formats date to spec' do
            progress_log = ProgressLog.new(on_day: DateTime.parse('2000-10-20'))
            date_s = helper.progress_log_on_day_s(progress_log)
            expect(date_s).to eq 'Friday 20th October, 2000'
        end
    end
end
