module RuboCop
  module Cop
    module RSpec
      class ExplicitPredicateMethod < Cop
        def on_send(node)
          _receiver, method, _args = *node

          return unless method.to_s.start_with?('be_')
          return if ignored_methods.include?(method.to_s)

          add_offense(node, :expression, predicate_message(method.to_s))
        end



        private

        def ignored_methods
          cop_config['IgnoredMethods'] || []
        end

        def predicate_message(method)
          predicate_method = method.gsub(/be_/, '') + '?'

          "Use `expect(object.#{predicate_method}).to eq true` instead of `expect(object).to #{method}`"
        end
      end
    end
  end
end
