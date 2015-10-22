require 'spec_helper'

describe OmniAuth::Strategies::Vanilla do

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end
  subject do
    OmniAuth::Strategies::Vanilla.new(nil, @options || {})
  end

  it_should_behave_like 'an oauth2 strategy'

  describe '#client' do
    it 'has correct site URL' do
      subject.client.site.should == 'http://apressen.o5.no'
    end

    it 'has correct authorize URL' do
      subject.client.authorize_url.should == 'http://apressen.o5.no/api/vanilla/v1/oauth/authorize'
    end

    it 'has correct token URL' do
      subject.client.token_url.should == 'http://apressen.o5.no/api/vanilla/v1/oauth/token'
    end
  end

  describe '#callback_path' do
    it "has the correct callback path" do
      subject.callback_path.should eq('/auth/vanilla/callback')
    end
  end

end
