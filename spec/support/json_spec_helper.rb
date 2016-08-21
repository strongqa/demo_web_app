require 'json_spec'
module JsonSpecHelper
  RSpec.configure do |config|
    config.include JsonSpec::Helpers
  end
end
