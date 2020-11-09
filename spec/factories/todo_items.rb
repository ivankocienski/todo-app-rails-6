
FactoryBot.define do

    factory :todo_item do
        description { "This is an item" }
        completed { false }
        created_at { Time.new(1980, 1, 1, 0, 0, 0) } # 1st January 1980, 0000hr
    end

    factory :todo_item_2, class: "TodoItem" do
        description { "Alpha alpha alpha" }
        completed { false }
        created_at { Time.new(1980, 1, 1, 0, 0, 0) } # 1st January 1980, 0000hr
    end

    factory :todo_item_3, class: "TodoItem" do
        description { "Beta beta beta" }
        completed { false }
        created_at { Time.new(1980, 1, 1, 0, 0, 0) } # 1st January 1980, 0000hr
    end
    
    #factory :todo_items {[ todo_item, todo_item_2, todo_item_3 ]}
end