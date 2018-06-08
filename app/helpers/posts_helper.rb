module PostsHelper
  def time_ago(duration)
    distance_of_time_in_words(duration) << ' ago'
  end
end
