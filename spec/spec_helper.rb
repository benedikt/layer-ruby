$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'layer/ruby'


RSpec.configure do |config|
  config.after(:each) do
    Layer::Client.app_id = Layer::Client.token = nil
  end
end
