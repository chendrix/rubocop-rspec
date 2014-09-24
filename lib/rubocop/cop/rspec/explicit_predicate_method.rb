module RuboCop
  module Cop
    module RSpec
      class ExplicitPredicateMethod < Cop
        def on_send(node)
          _receiver, method, _args = *node

          return unless method.to_s.start_with?('be_')
          return if ignored_methods.include?(method.to_s)

          add_offense(node, :expression, 'Prefer use of explicit predicate method tests')
        end

        private

        def ignored_methods
          cop_config['IgnoredMethods'] || []
        end
      end
    end
  end
end
