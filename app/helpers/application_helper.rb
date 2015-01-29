module ApplicationHelper
  APPLICATION_NAME = "Demo web application"

  def title(text, with_h3: true)
    content_for(:title){ text }
    content_tag(:h3, text) if with_h3
  end
end
