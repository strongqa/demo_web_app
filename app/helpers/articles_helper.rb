module ArticlesHelper
  def group_by_created_at(articles)
    articles.each_with_object(Hash.new([])) do |el, res|
      res[el.created_at.to_date] = res[el.created_at.to_date] + [el]
      res
    end
  end

  def today_or_date(date)
    date == Time.zone.today ? 'Today' : date
  end
end
