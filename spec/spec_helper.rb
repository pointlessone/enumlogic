$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'spec'
require 'spec/autorun'
require 'rubygems'
require 'active_record'
require "#{File.dirname(__FILE__)}/../init"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Base.configurations = true

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define(:version => 1) do
  create_table :computers do |t|
    t.integer :kind
  end

  create_table :cars do |t|
    t.integer :model
  end
end

Spec::Runner.configure do |config|
  config.before(:each) do
    class ::Computer < ActiveRecord::Base
    end
    class ::Car < ActiveRecord::Base
    end
  end

  config.after(:each) do
    Object.send(:remove_const, :Computer)
    Object.send(:remove_const, :Car)
  end
end
