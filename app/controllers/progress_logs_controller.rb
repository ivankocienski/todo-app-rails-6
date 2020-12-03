class ProgressLogsController < ApplicationController
    def index
        @progress_logs = ProgressLog.all
    end

    # def new; end

    # def create; end
end
