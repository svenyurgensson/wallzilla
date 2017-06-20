require "net/http"
require "tempfile"
require "uri"
require "json"

module Wallzilla
  module Fetcher
    extend Fetcher
    WRONG_API_KEY = "Your Flicker API key "

    # Downoads image to tempfile for the given keyword
    # returns:
    #   file handler if image found and downloaded
    #   nil if no image found
    def fetch(keyword)
      if image = search_image(keyword)
        download_photo(image)
      else
        nil
      end
    end

    def search_image(keyword)
      url = flickr_search_url(keyword)
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)

      result = JSON.parse(response.body)

      if (100...117).cover?(result["code"])
        fail(result["message"])
      end

      photos = result["photos"]["photo"]
      return nil if photos.empty?

      photos.first[photo_size_code]
    end

    def download_photo(url)
      uri = URI.parse(url)
      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
        resp = http.get(uri.path)
        file = Tempfile.new(["flickr", ".jpg"], encoding: "binary")
        file.binmode
        file.write(resp.body)
        file.flush
        file
      end
    end

    private

    def flickr_search_url(keyword, key = flickr_api_key)
      "https://api.flickr.com/services/rest/?method=flickr.photos.search" +
        "&api_key=#{key}" +
        "&text=#{keyword}" +
        "&content_type=1" + # Only photos
        "&sort=interestingness-desc" +
        "&extras=#{photo_size_code}" +
        "&media=photos" +
        "&per_page=1" +
        "&format=json" +
        "&nojsoncallback=1"
    end

    def photo_size_code
      "url_c"
    end

    def flickr_api_key
      Wallzilla::Runner.flickr_api_key
    end
  end
end
