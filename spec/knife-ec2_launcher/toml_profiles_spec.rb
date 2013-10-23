require 'spec_helper'
require 'knife-ec2_launcher/toml_profiles'

describe Knife::Ec2Launcher::TOMLProfiles do
  context 'when config file does not exist' do
    let :toml_config_path do
      File.expand_path('../../fixtures/config/does_not_exist', __FILE__)
    end

    let :profiles do
      described_class.new(toml_config_path)
    end

    it 'raise an exception' do
      expect { profiles.config }.to raise_error Errno::ENOENT
    end
  end

  context 'when config file exists' do
    let :toml_config_path do
      File.expand_path('../../fixtures/config/ec2.toml', __FILE__)
    end

    let :profiles do
      described_class.new(toml_config_path)
    end

    describe '#all' do
      subject do
        profiles.all
      end

      it 'lists the profiles from the config file' do
        expect(subject).to eq ['test', 'test_2']
      end
    end

    describe '#[]' do
      subject do
        profiles['test']
      end

      it 'lists the profiles from the config file' do
        expected_config = {
          'security_groups' => ['dev'],
          'run_list'        => ['recipe[build-essential]', 'role[base]'],
          'environment'     => 'dev',
          'distro'          => 'chef-full',
          'image'           => 'ami-0dadba79',
          'flavor'          => 'm1.small'
        }
        expect(subject).to eq expected_config
      end
    end
  end
end
