module ApplicationHelper
    def navigation_link(path, mode, title)
        active = ''
        img_src = ''

        if @navigation == mode
            active = 'class="active"'
            img_src = asset_path("nav_icon_#{mode}_on.png")

        else
            img_src = asset_path("nav_icon_#{mode}_off.png")
        end

        html  = "<a href='#{path}' #{active}>"
        html += "<img class='icon' src='#{img_src}' />"
        html += "<span>#{title}</span>"
        html += '</a>'

        html.html_safe
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

    def render_flash(flash)
        return '' if flash.empty?

        html = '<div id="flash-box">'
        flash.each do |severity, message|
            html += "<p class='flash' id='flash-#{severity}'>#{message}</p>"
        end
        html += '</div>'

        html.html_safe
    end
end
