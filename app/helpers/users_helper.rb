module UsersHelper

  def relative_time(created_at)
    time_ago_in_words(created_at)
  end

  def formatted_time(created_at)
    created_at.strftime("%b %d, %Y")
  end

end
