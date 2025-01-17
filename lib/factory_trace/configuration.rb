module FactoryTrace
  class Configuration
    attr_accessor :path, :enabled, :color, :mode

    def initialize
      @enabled = ENV.key?('FB_TRACE') || ENV.key?('FB_TRACE_FILE')
      @path = ENV['FB_TRACE_FILE']
      @color = path.nil?
      @mode = extract_mode(ENV['FB_TRACE']) || :full
    end

    def out
      return STDOUT unless path

      File.open(path, 'w')
    end

    def mode?(*args)
      args.include?(mode)
    end

    private

    def extract_mode(value)
      matcher = value && value.match(/full|trace_only/)
      matcher && matcher[0].to_sym
    end
  end
end
