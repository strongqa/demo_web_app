module CommentsHelper
  def comment_created_date(comment)
    comment.created_at.strftime('%B %d, %Y at %I:%M %P') if comment.created_at.present?
  end
end
