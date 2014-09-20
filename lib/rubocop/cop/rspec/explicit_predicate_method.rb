module RuboCop
  module Cop
    module RSpec
      class ExplicitPredicateMethod < Cop
        IGNORED_METHODS = [:be_a, :be_empty]

        def on_send(node)
          receiver, method, args = *node

          return unless method.to_s.start_with?('be_')
          return if IGNORED_METHODS.include?(method)

          add_offense(node, :expression, 'Prefer use of explicit predicate method tests')
        end
      end
    end
  end
end
