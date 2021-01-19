require 'rails_helper'

describe RootAspirationPresenter do
    include Capybara::RSpecMatchers

    context '#render' do
        context 'with aspiration' do
            let(:aspiration) { FactoryBot.create(:aspiration) }

            it 'returns HTML with aspiration title' do
                presenter = RootAspirationPresenter.new(aspiration)
                html = presenter.render

                expect(html).to be_a(String)
                expect(html).to have_selector('li .aspiration-title', text: 'Learning German')
            end

            context 'with todo items' do
                before :each do
                    %i[todo_list todo_list_2 todo_list_3]
                        .map { |todo_list_name| FactoryBot.create(todo_list_name, aspiration: aspiration) }
                    aspiration.reload
                end

                it 'returns HTML of todo items' do
                    presenter = RootAspirationPresenter.new(aspiration)
                    html = presenter.render

                    expect(html).to be_a(String)
                    expect(html).to have_selector('li.todo-list', count: 3)
                end
            end
        end
    end
end