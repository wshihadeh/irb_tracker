require 'spec_helper'

RSpec.describe IRBTracker::LDAPLogin do
  subject { described_class }

  context 'No LDAP connection' do
    it 'return false if it fails to authenticate' do
      expect(subject.authenticate('user', '12345')).to eq false
    end
  end

  context 'LDAP connection is avalable' do
    let(:conn) { double('conn') }

    before do
      allow(Net::LDAP).to receive(:new).and_return(conn)
      allow(conn).to receive(:auth)
      allow(conn).to receive(:bind).and_return(true)
      allow(conn).to receive(:bind_as).and_return(true)
    end

    it 'return false if user is valid' do
      expect(subject.authenticate('user', '12345')).to eq true
    end
  end
end
