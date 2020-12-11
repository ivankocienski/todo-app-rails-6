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
end
