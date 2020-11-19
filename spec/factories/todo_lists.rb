FactoryBot.define do
    factory :todo_list do
        title { 'This is todo list' }
        created_at { Time.new(1982, 1, 1, 0, 0, 0) } # 1st January 1980, 0000hr
    end

    factory :todo_list_2, class: 'TodoList' do
        title { 'Alpha alpha alpha' }
        created_at { Time.new(1982, 1, 1, 0, 0, 0) } # 1st January 1980, 0000hr
    end

    factory :todo_list_3, class: 'TodoList' do
        title { 'Beta beta beta' }
        created_at { Time.new(1982, 1, 1, 0, 0, 0) } # 1st January 1980, 0000hr
    end
end
