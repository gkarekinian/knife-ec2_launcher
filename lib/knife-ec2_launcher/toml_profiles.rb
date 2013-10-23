require 'toml'
require 'knife-ec2_launcher/configuration'

module Knife
  module Ec2Launcher
    class TOMLProfiles
      include Configuration

      parser TOML
    end
  end
end
