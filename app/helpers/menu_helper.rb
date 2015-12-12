module MenuHelper
  def menu(name)
    menu = Menu.find_or_create_by(name: name)
    html = ''

    menu.links.each do |l|
      if l.new_tab?
        html << link_to(l.title, l.url, target: '_blank')

      else
        html << link_to(l.title, l.url)

      end
    end

    html.html_safe
  end
end
