module ArticlesHelper
  def group_by_created_at(articles)
    articles.inject(Hash.new([])) { |res, el| res.tap{ res[el.created_at.to_date] = res[el.created_at.to_date] + [el]}}
  end

  def today_or_date(date)
    date == Date.today ? 'Today' : date
  end
end
