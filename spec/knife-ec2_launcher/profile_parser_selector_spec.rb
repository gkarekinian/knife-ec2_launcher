require 'spec_helper'
require 'knife-ec2_launcher/profile_parser_selector'
require 'knife-ec2_launcher/yaml_profiles'
require 'knife-ec2_launcher/toml_profiles'

describe Knife::Ec2Launcher::ProfileParserSelector do
  describe '#load' do
    subject do
      profiles.load
    end

    let :profiles do
      described_class.new(config_path)
    end

    context 'when config file does not exist' do
      let :config_path do
        File.expand_path('../../fixtures/config/ec2.txt', __FILE__)
      end

      it 'raises an exception' do
        expect { subject }.
          to raise_error Knife::Ec2Launcher::NoParserForFileTypeError
      end
    end

    context 'when config file is a yaml file' do
      let :config_path do
        File.expand_path('../../fixtures/config/ec2.yml', __FILE__)
      end

      it 'loads the file as YAML' do
        Knife::Ec2Launcher::YAMLProfiles.should_receive(:new).with(config_path)

        subject
      end
    end

    context 'when config file is a toml file' do
      subject do
        profiles.load
      end

      let :config_path do
        File.expand_path('../../fixtures/config/ec2.toml', __FILE__)
      end

      it 'loads the file as TOML' do
        Knife::Ec2Launcher::TOMLProfiles.should_receive(:new).with(config_path)

        subject
      end
    end
  end
end
