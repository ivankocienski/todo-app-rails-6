require 'rails_helper'

describe 'progress_logs/index', type: :view do
    it 'renders list of progress log items' do
        assign :progress_logs, [
            FactoryBot.create(:progress_log),
            FactoryBot.create(:progress_log_2),
            FactoryBot.create(:progress_log_3)
        ]
        render
        expect(rendered).to have_selector('ul#progress-logs li', count: 3)
    end
end
