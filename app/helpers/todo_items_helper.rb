module TodoItemsHelper
    def todo_item_title_status(item)
        item.description + (item.completed ? ' (done)' : '')
    end

    def aspiration_options(options)
        return [] if options.nil?

        [['No Aspiration', '']] +
            options.map do |opt|
                [opt.title, opt.id]
            end
    end
end
