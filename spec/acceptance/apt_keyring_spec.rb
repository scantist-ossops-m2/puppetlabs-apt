# frozen_string_literal: true

require 'spec_helper_acceptance'

PUPPETLABS_FILE_CHECK_COMMAND = 'ls /etc/apt/keyrings | grep \'puppetlabs-keyring.gpg\''

describe 'apt::keyring' do
  context 'when using default values and source specified explicitly' do
    let(:keyring_pp) do
      <<-MANIFEST
    		apt::keyring { 'puppetlabs-keyring.gpg':
  				source => 'https://apt.puppetlabs.com/keyring.gpg',
    		}
      MANIFEST
    end

    it 'applies idempotently' do
      retry_on_error_matching do
        idempotent_apply(keyring_pp)
      end
    end

    it 'expects file to be present at default location' do
      run_shell(PUPPETLABS_FILE_CHECK_COMMAND.to_s)
    end
  end
end
