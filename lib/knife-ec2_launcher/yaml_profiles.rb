require 'yaml'
require 'knife-ec2_launcher/configuration'

module Knife
  module Ec2Launcher
    # Loads a YAML file containing a nested hash of profiles in a `profiles`
    # namespace. For example:
    #
    #     profiles:
    #       test:
    #         security_groups:
    #           - "dev"
    #         run_list:
    #           - "recipe[build-essential]"
    #           - "role[base]"
    #         environment: "dev"
    #         distro: "chef-full"
    #         image: "ami-0dadba79"
    #         flavor: "m1.small"
    class YAMLProfiles
      include Configuration

      parser YAML
    end
  end
end
