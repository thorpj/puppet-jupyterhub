# Check if jupyterhub is set up correctly
require 'spec_helper'

describe 'jupyterhub' do
  on_supported_os.select { |_, f| f[:os]['family'] != 'Solaris' }.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }
      describe "Testing the dependancies between the classes" do

        it { should include_class('jupyterhub::install') }
        it { should include_class('jupyterhub::config') }
        it { should include_class('jupyterhub::service') }
        it { is_expected.to include_class('jupyterhub::install').that_comes_before('jupyterhub::config') }
        it { is_expected.to include_class('jupyterhub::service').that_subscribes_to('jupyterhub::config') }

        it { is_expected.to contain_service('jupyterhub') }
      end
    end
  end
end
