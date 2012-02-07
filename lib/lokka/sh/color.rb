module Lokka
  module Sh
    module Color
      @colors =
        { :r_video  => 7,  :black   => 30, :red      => 31, :green      => 32, :yellow  => 33,
          :blue     => 34, :magenta => 35, :cyan     => 36, :white      => 27, :default => 39,
          :bg_black => 40, :bg_red  => 41, :bg_green => 42, :bg_default => 49 }

      def self.with(name, &block)
        puts "\e[#{@colors[name.to_sym]}m" + yield + "\e[0m"
      end
    end
  end
end
