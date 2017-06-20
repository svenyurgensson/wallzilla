module Wallzilla
  module Montage
    extend Montage

    def process!(file_handlers, output, fill)
      files = file_handlers.map(&:path).join(" ")
      cmd = "#{montage} -mode concatenate -background #{fill} -tile 5x2 #{files} #{output}"
      system(cmd)
    end

    def montage
      Gem.win_platform? ? "montage.exe" : "montage"
    end
  end
end
