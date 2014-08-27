require 'spec_helper'

describe 'logstash::package' do
  let :default_params do
    {
      :package_ensure      => 'installed',
    }
  end

  shared_examples_for 'logstash::package' do
    describe 'with default params' do
      it { should contain_package('logstash').with(
        :ensure => 'installed',
        :name   => platform_params[:package_name]
      )}
    end

    describe 'with parameters overridden' do
      let :params do
        default_params.merge!({
                                :package_name   => 'logstash-fork',
                                :package_ensure => 'latest',
                              })
      end
      it { should contain_package('logstash').with(
        :ensure => 'latest',
        :name   => 'logstash-fork'
      )}
    end
  end

  context 'on Debian platforms' do
    let :facts do
      {
        :osfamily               => 'Debian',
        :operatingsystem        => 'Debian',
        :lsbdistid              => 'wheezy'
      }
    end

    let :platform_params do
      {
        :package_name      => 'logstash',
      }
    end
    it_configures 'logstash::package'
  end

  context 'on RedHat platforms' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystem        => 'RedHat',
        :operatingsystemrelease => '6.5'
      }
    end

    let :platform_params do
      {
        :package_name      => 'logstash',
      }
    end

    it_configures 'logstash::package'
  end
end
