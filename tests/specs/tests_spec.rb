# encoding: utf-8

control '01' do
  impact 1.0
  title 'Verify prometheus '
  desc 'Ensures prometheus service and web is up and running'

  describe service('prometheus') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
  describe user("prometheus") do
    it { should exist }
  end
  describe group("prometheus") do
    it { should exist }
  end

  describe port(9090) do
    it { should be_listening }
    its('processes') {should include 'prometheus'}
  end
  describe http('http://127.0.0.1:9090/config') do
    its('status') { should cmp 200 }
  end

end