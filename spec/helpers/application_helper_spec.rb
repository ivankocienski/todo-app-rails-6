require 'rails_helper'

describe ApplicationHelper, type: :helper do
    context '#navigation_link' do
        it 'returns link in default mode' do
            link = navigation_link('/path_to_thing', :path_to_thing, 'Path to thing')
            expect(link).to have_selector("a[href='/path_to_thing']", text: 'Path to thing')
        end

        it 'returns active link in correct mode' do
            assign :navigation, :path_to_thing
            link = helper.navigation_link('/path_to_thing', :path_to_thing, 'Path to thing')
            expect(link).to have_selector("a[href='/path_to_thing'][class='active']", text: 'Path to thing')
        end
    end
end