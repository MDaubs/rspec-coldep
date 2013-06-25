require 'rspec'

module RSpec
  module Coldep
    class StubBuilder
      def initialize(target)
        @target = target
      end

      def method_missing(method, *args, &block)
        @stub = [method, args]
        self
      end

      def ==(return_value)
        @target.stub(@stub[0]).with(*@stub[1]).and_return(return_value)
      end
    end

    module Helpers
      def collaborator(name = nil)
        double(name).tap do |fake|
          yield StubBuilder.new(fake)
        end
      end

      def dependency(stub_class_name)
        fake = double
        stub_const(stub_class_name, StubBuilder.new(fake))
        yield
        stub_const(stub_class_name, fake)
      end
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Coldep::Helpers
end
