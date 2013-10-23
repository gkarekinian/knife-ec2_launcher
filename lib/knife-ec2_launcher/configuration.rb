module Knife
  module Ec2Launcher
    module Configuration
      attr_reader :profiles
      attr_reader :config_file

      def self.included(base)
        base.extend(ClassMethods)
      end

      def initialize(config_file)
        @config_file = config_file
        @profiles    = config
      end

      # list of profile names
      def all
        @all ||= profiles.map(&:first)
      end

      def [](profile)
        profiles[profile]
      end

      def parser
        self.class.parser
      end

      module ClassMethods
        def parser(parser=nil)
          @parser ||= parser
        end
      end

      private
      def config
        parser.load_file(@config_file)
      end
    end
  end
end
