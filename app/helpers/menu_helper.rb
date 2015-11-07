module MenuHelper
  def menu(name)
    menu = Menu.find_by(name: name)
    html = ''

    menu.links.each do |l|
      if l.target_blank
        html << link_to(l.title, l.url, _target: '_blank')

      else
        html << link_to(l.title, l.url)

      end
    end

    html.html_safe
  end
end
