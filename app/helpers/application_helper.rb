module ApplicationHelper
    def navigation_link(path, mode, title)
        active = ''
        active = 'class="active"' if @navigation == mode

        %(<a href="#{path}" #{active}>#{title}</a>).html_safe
    end

    def field_errors_for(record, field)
        return '' if record.errors[field].empty?

        html = '<ul class="field-errors">'
        record.errors[field].each do |description|
            html += "<li>#{description}}</li>"
        end
        html += '</ul>'

        html.html_safe
    end
end
