module Wallzilla
  module Words
    extend Words

    # @params [size_range] # Example: 3...9
    #
    # returns:
    # random word from dictionary word list file
    def random_word(size_range, window = 4)
      f = File.open(Wallzilla::Runner.dict_file, 'r')
      fsize = f.size
      loop do
        f.seek(rand(fsize))
        next if f.eof?
        f.readline
        window.times do
          break if f.eof
          w = f.readline.strip
          if size_range.cover? w.size
            f.close
            return w
          end
        end
      end
    end
  end
end
