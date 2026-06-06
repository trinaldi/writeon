module Graphql
  class VariablesParser
    def self.call(input)
      new(input).call
    end

    def initialize(input)
      @input = input
    end

    def call
      return {} if @input.nil?

      handlers.fetch(@input.class) { default_handler }.call(@input)
    end

    private

    def handlers
      {
        String => method(:handle_string),
        Hash => method(:handle_hash),
        ActionController::Parameters => method(:handle_params)
      }
    end

    def handle_string(input)
      return {} if input.empty?

      JSON.parse(input)
    end

    def handle_hash(input)
      input
    end

    def handle_params(input)
      input.to_unsafe_hash
    end

    def default_handler
      ->(input) { raise ArgumentError, "Unexpected parameter: #{input}" }
    end
  end
end
