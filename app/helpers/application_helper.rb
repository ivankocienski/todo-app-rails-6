module ApplicationHelper

    def navigation_link(path, mode, title)
        active = ''
        active = 'class="active"' if @navigation == mode

        %Q{<a href="#{path}" #{active}>#{title}</a>}.html_safe
    end
end
