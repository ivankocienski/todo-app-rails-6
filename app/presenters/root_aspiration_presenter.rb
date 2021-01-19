class RootAspirationPresenter
    include Rails.application.routes.url_helpers

    def initialize(aspiration)
        @aspiration = aspiration
    end

    def render
        html = "<li class='aspiration'>\n"
        html += "  <span class='aspiration-title'>#{aspiration_link}'</span>\n"
        html += render_todo_lists
        html += "</li>\n"

        html.html_safe
    end

    private

    def aspiration_link
        h.link_to @aspiration.title, aspiration_path(@aspiration)
    end

    def render_todo_lists
        return '' if @aspiration.todo_lists.empty?

        html = "  <ul class='todo-lists'>\n"
        @aspiration.todo_lists.each do |todo_list|
            html += todo_list_for_aspiration(todo_list)
        end

        html += "  </ul>\n"
        html
    end

    def todo_list_for_aspiration(todo_list)
        <<-HTML
        <li class='todo-list'>
            <span class='todo-list-title'>#{todo_list_link(todo_list)}</span>
        </li>
        HTML
    end

    def todo_list_link(todo_list)
        h.link_to todo_list.title, todo_path(todo_list)
    end

    # rails helpers

    def h
        ActionController::Base.helpers
    end
end