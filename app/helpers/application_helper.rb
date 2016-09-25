module ApplicationHelper
  APPLICATION_NAME = 'Demo web application'.freeze

  def title(text, with_h3: true)
    content_for(:title) { text }
    content_tag(:h3, text) if with_h3
  end

  def current_tab_class(tab_name)
    if current_tab == tab_name
      'active'
    end
  end
end
