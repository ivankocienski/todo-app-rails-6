FactoryBot.define do
    factory :aspiration do
        title { 'Learning German' }
        description { 'A longer description of the aspiration' }
    end
    factory :aspiration_2, class: 'Aspiration' do
        title { 'Being better at art' }
        description { '' }
    end
    factory :aspiration_3, class: 'Aspiration' do
        title { 'Build robot' }
        description { 'To take over world and tidy room' }
    end
end
