require 'rails_helper'

describe 'progress_logs/new', type: :view do
    before :each do
        assign :progress_log, ProgressLog.new
    end

    it 'has a title' do
        render
        expect(rendered).to have_selector('h1', text: 'Write Progress Log')
    end

    it 'has form' do
        render

        # form
        path = '/progress_logs'
        form_filter = "form[action='#{path}'][method='post']"
        expect(rendered).to have_selector(form_filter)
    end
end
