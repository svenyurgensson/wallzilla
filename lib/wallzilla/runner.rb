module Wallzilla
  module Runner
    extend Runner

    KEYWORDS_SIZE       = 10
    KW_LEN_RANGE        = 4...10
    DEFAULT_FILENAME    = "output.jpg"
    NO_WORDS_FILE_FOUND = "Sorry, but no one words list file found!"

    def build(kw:, result:, key:, words: nil, tiles: "4x3", bg: "black")
      @_output_file = result
      @_key         = key
      @wordlist     = words
      @tiles        = tiles
      @_fill        = bg

      run!(kw)
    end

    def run!(kw)
      keywords = normalize(kw)

      photos = process_photos(keywords)

      Wallzilla::Montage.process!(photos, output_file, fill)
    ensure
      clean(photos) if photos
    end

    def process_photos(kw)
      kw.map do |word|
        loop do
          url = fetch(word)
          break url if url
          word = random_word
        end
      end
    end

    def clean(photos)
      photos.map { |x| x.close; x.unlink }
    end

    def fetch(kw)
      Wallzilla::Fetcher.fetch(kw)
    end

    def fill
      return @_fill if defined?(@_fill)

      @_fill =
        ENV["background_color"] || "black"
    end

    def output_file
      return @_output_file if defined?(@_output_file)

      @_output_file =
        ENV["result_file"] || File.join(Dir.pwd, DEFAULT_FILENAME)
    end

    def flickr_api_key
      return @_key if defined?(@_key)

      @_key = ENV.fetch("FLICKR_KEY") do |e|
        fail("You should provide Flickr API application key! (--key key_string)")
      end
    end

    def dict_file
      return @_dict if defined?(@_dict)

      @_dict = maybe_dictionaries.
                 uniq.
                 compact.
                 select { |f| FileTest.readable?(f) }.first || fail(NO_WORDS_FILE_FOUND)
    end

    def maybe_dictionaries
      Array(@wordlist) +
        Array(ENV["words_file"]) +
        ["/usr/share/dict/words", "/usr/share/words"]
    end

    def normalize(kw)
      Array.new(KEYWORDS_SIZE) do |i|
        kw[i] || random_word
      end
    end

    def random_word
      Wallzilla::Words.random_word(KW_LEN_RANGE)
    end
  end
end
