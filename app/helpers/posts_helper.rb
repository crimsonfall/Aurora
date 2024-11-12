module PostsHelper
  def find_hashtags(text)
    results = text.scan(/#\w+/)
    results.each do |result|
      result_link = link_to result, posts_path(search: result)
      text.gsub!(result, result_link)
    end
    text
  end
end
