module ProgressLogsHelper
    def progress_log_on_day_s(progress_log)
        date = progress_log.on_day
        ordinal_day = date.mday.ordinalize
        date.strftime("%A #{ordinal_day} %B, %Y")
    end

    def open_todo_item_options(options)
        return [] if options.nil?

        [['No Todo Item', '']] +
            options.map do |opt|
                [opt.description, opt.id]
            end
    end

    def progress_log_todo_item_link(progress_log)
        title = progress_log.todo_item.description
        href = todo_list_todo_item_path(progress_log.todo_item.todo_list, progress_log.todo_item)

        link_to(title, href).html_safe
    end
end
