# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

module Seeder
    MODELS = [TodoItem, TodoList, Aspiration, ProgressLog].freeze

    module_function

    def verify_environment
        return if Rails.env.development?

        raise 'You cannot run db:seed in non-development environment!'
    end

    def does_db_contain_data?
        MODELS.any? { |klass| klass.count.positive? }
    end

    def warn_user_now
        puts <<-WARNING
            ****************
            *  WARNING!!!  *
            ****************

              >
              > This action is going to delete ALL the data from the database!
              >   ctrl-c this action or else.
              >
              > !!! YOU HAVE BEEN WARNED !!!

            Tables contain
        WARNING

        MODELS.each do |klass|
            puts "  #{klass} has #{klass.count} rows"
        end

        print '(now waiting 15 seconds for abort)'
        sleep 15

        puts "\n\nokilydokily!"
    end

    def delete_all_data
        MODELS.each do |klass|
            puts "deleting #{klass}"
            klass.delete_all
        end
    end

    def seed_aspirations
        @aspirations = []
        @aspirations << Aspiration.create!(title: 'Deutsch')
        @aspirations << Aspiration.create!(title: 'Electronics')
        @aspirations << Aspiration.create!(title: 'Art and Artistry')
        @aspirations << Aspiration.create!(title: 'Creative Writing')
    end

    def seed_todo_listss
        @todo_lists = []
        @todo_lists << TodoList.create!(title: 'Transistors', aspiration: @aspirations[1])
        @todo_lists << TodoList.create!(title: 'Basic Grammar', aspiration: @aspirations[0])
        @todo_lists << TodoList.create!(title: 'Fine drawing', aspiration: @aspirations[2])
        @todo_lists << TodoList.create!(title: 'Digital Art', aspiration: @aspirations[2])
        @todo_lists << TodoList.create!(title: 'Ohms law', aspiration: @aspirations[1])
    end

    def seed_todo_items
        @todo_items = []

        # electronics
        @todo_items << @todo_lists[0].todo_items.create!(description: 'Electrons and semi conductors')
        @todo_items << @todo_lists[0].todo_items.create!(description: 'hFE number and meaning')
        @todo_items << @todo_lists[0].todo_items.create!(description: 'Basic switch circuit')
        @todo_items << @todo_lists[0].todo_items.create!(description: 'Biasing')

        # Deutsch
        @todo_items << @todo_lists[1].todo_items.create!(description: 'Der, Die unt Das')
        @todo_items << @todo_lists[1].todo_items.create!(description: 'Ich Habe...')
        @todo_items << @todo_lists[1].todo_items.create!(description: 'Eins, zwie, drie, fur, funf ...')
        @todo_items << @todo_lists[1].todo_items.create!(description: 'Rot, blau, gruun, schwarz ...')

        # drawing
        @todo_items << @todo_lists[2].todo_items.create!(description: 'line rendering')
        @todo_items << @todo_lists[2].todo_items.create!(description: 'tone')
        @todo_items << @todo_lists[2].todo_items.create!(description: '3D shapes')
        @todo_items << @todo_lists[2].todo_items.create!(description: 'shadow')

        # digital drawing
        @todo_items << @todo_lists[3].todo_items.create!(description: 'paintbrush, airbrush, eraser')
        @todo_items << @todo_lists[3].todo_items.create!(description: 'layers')

        # ohms law
        @todo_items << @todo_lists[4].todo_items.create!(description: 'basic resistance')
        @todo_items << @todo_lists[4].todo_items.create!(description: 'parallel and seriese resistance')
        @todo_items << @todo_lists[4].todo_items.create!(description: 'capacitors as resistors')
    end

    def seed_progress_logs
        @progress_logs = []

        @progress_logs << ProgressLog.create!(
            description: 'Did a thing. Some stuff was accomplished. It is fine.'
        )

        @progress_logs << ProgressLog.create!(
            description: 'Worked on another bit. Lots of things to say about this one.',
            todo_item: @todo_items[2]
        )
    end

    def run!
        verify_environment

        if does_db_contain_data?
            warn_user_now 
            delete_all_data
        end

        seed_aspirations
        seed_todo_listss
        seed_todo_items
        seed_progress_logs

        puts 'done!'
    end
end

Seeder.run!