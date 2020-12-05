FactoryBot.define do
    factory :progress_log do
        on_day { '2000-01-01 00:00:00' } # sunday
        description { 'Did this thing today. It is super important that i write about it.' }
    end
    factory :progress_log_2, class: 'ProgressLog' do
        on_day { '2000-01-02 00:00:00' } # monday
        description { 'Worked on that thing a lot. There still needs to be work on it.' }
    end
    factory :progress_log_3, class: 'ProgressLog' do
        on_day { '2000-01-03 00:00:00' } # tuesday
        description { 'Made progress here. Going to try something else tomorrow.' }
    end
end
