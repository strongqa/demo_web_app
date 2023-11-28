module SvgHelper
  def svg(name)
    file_path = Rails.root.join('app', 'assets', 'images', "#{name}.svg")
    return File.read(file_path).html_safe if File.exist?(file_path)

    '(not found)'
  end
end
