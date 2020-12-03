module ProgressLogsHelper
    def progress_log_on_day_s(progress_log)
        date = progress_log.on_day
        ordinal_day = date.mday.ordinalize
        date.strftime("%A #{ordinal_day} %B, %Y")
    end
end
