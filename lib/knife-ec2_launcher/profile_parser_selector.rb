require 'knife-ec2_launcher/yaml_profiles'
require 'knife-ec2_launcher/toml_profiles'

module Knife
  module Ec2Launcher
    class ProfileParserSelector
      attr_reader :path

      # Overwrite the constructor to return a different class
      def initialize(path)
        raise Errno::ENOENT unless File.exist?(path)
        @path = path
      end

      def load
        extension = File.extname(path)

        parser = if extension.match(/^\.y[a]*ml$/)
                   YAMLProfiles
                 elsif extension == '.toml'
                   TOMLProfiles
                 else
                   raise NoParserForFileTypeError
                 end

        parser.new(path)
      end

    end
  end
end
