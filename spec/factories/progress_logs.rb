FactoryBot.define do
    factory :progress_log do
        on_day { '2000-01-01 00:00:00' } # sunday
        description { 'Did this thing today' }
    end
    factory :progress_log_2, class: 'ProgressLog' do
        on_day { '2000-01-02 00:00:00' } # monday
        description { 'Worked on that thing a lot' }
    end
    factory :progress_log_3, class: 'ProgressLog' do
        on_day { '2000-01-03 00:00:00' } # tuesday
        description { 'Made progress here' }
    end
end
