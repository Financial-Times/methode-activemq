require 'spec_helper'
describe 'methode_activemq' do
  context 'with default values for all parameters' do
    it { should contain_class('methode_activemq') }
  end
end
