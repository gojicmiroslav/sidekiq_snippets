class DpasteWorker
  include Sidekiq::Worker

  def perform(snippet_id)
  	snippet = Snippet.find(snippet_id)
    uri = URI.parse("http://dpaste.com/api/v2/")
    request = Net::HTTP.post_form(uri, lang: snippet.language, code: snippet.plain_code)
    snippet.update_attribute(:highlighted_code, request.body.to_s.encode)  
  end
end
