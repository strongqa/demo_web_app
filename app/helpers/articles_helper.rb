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

  def show_day(created_at)
    created_at.strftime('%d')
  end

  def show_month_short(created_at)
    created_at.strftime('%b')
  end

  def show_date(created_at)
    created_at.strftime('%d %B, %Y')
  end

  def count_comments(comments)
    if comments.any?
      comments_count = comments.count
      comments_count > 1 ? "#{comments_count} Comments" : '1 Comment'
    else
      'No comments yet'
    end
  end
end
