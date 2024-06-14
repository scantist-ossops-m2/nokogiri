# frozen_string_literal: true

# This file was based heavily on work done in the SyntaxTree::CSS project at
# https://github.com/ruby-syntax-tree/syntax_tree-css
#
# The MIT License (MIT)
#
# Copyright (c) 2022-2024 Kevin Newton
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module Nokogiri
  module CSS
    # :nodoc: all
    class Selectors
      # Parses selectors according to https://www.w3.org/TR/selectors-4 from the version dated 7 May
      # 2022.
      class Parser
        class MissingTokenError < Nokogiri::CSS::SyntaxError
        end

        # A custom enumerator around the list of tokens. This allows us to save a
        # reference to where we are when we're looking at the stream and rollback
        # to that point if we need to.
        class TokenEnumerator
          class Rollback < StandardError
          end

          attr_reader :tokens, :index

          def initialize(tokens)
            @tokens = tokens
            @index = 0
          end

          def next
            @tokens[@index].tap { @index += 1 }
          end

          def peek
            @tokens[@index]
          end

          def transaction
            saved = @index
            yield
          rescue Rollback
            @index = saved
            nil
          end
        end

        attr_reader :tokens

        def initialize(tokens)
          @tokens = TokenEnumerator.new(tokens)
        end

        def parse
          selector_list.tap do
            # TODO: add tests for error detection / handling
            token = tokens.peek
            unless token.nil? || EOFToken === token
              token_message = token.respond_to?(:value) ? token.value : token.class.name
              message = format(
                "Unexpected token '%s' at character %d",
                token_message,
                token.location.to_range.begin + 1,
              )
              raise Nokogiri::CSS::SyntaxError, message
            end
          end
        end

        private

        #-------------------------------------------------------------------------
        # Parsing methods
        #-------------------------------------------------------------------------

        # <selector-list> = <complex-selector-list>
        def selector_list
          complex_selector_list
        end

        # <complex-selector-list> = <complex-selector>#
        def complex_selector_list
          one_or_more { complex_selector }
        end

        # <compound-selector-list> = <compound-selector>#
        def compound_selector_list
          one_or_more { compound_selector }
        end

        # <relative-selector-list> = <relative-selector>#
        def relative_selector_list
          raise "TODO: needs a test"
          one_or_more { relative_selector }
        end

        # <complex-selector> = <compound-selector> [ <combinator>? <compound-selector> ]*
        def complex_selector
          left_ = compound_selector

          if (combinator_ = maybe { combinator })
            right_ = complex_selector
            ComplexSelector.new(left: left_, combinator: combinator_, right: right_)
          else
            left_
          end
        end

        # <relative-selector> = <combinator>? <complex-selector>
        def relative_selector
          raise "TODO: needs a test"
          if (c = maybe { combinator })
            RelativeSelector.new(combinator: c, complex_selector: complex_selector)
          else
            complex_selector
          end
        end

        # <compound-selector> = [ <type-selector>? <subclass-selector>*
        #   [ <pseudo-element-selector> <pseudo-class-selector>* ]* ]!
        def compound_selector
          type = maybe { type_selector }

          subclasses = []
          while (subclass = maybe { subclass_selector })
            subclasses << subclass
          end

          pseudo_elements = []
          while (pseudo_element = maybe { pseudo_element_selector })
            raise "TODO: need to test"
            pseudo_classes = []
            while (pseudo_class = maybe { pseudo_class_selector })
              pseudo_classes << pseudo_class
            end

            pseudo_elements << [pseudo_element, pseudo_classes]
          end

          if type.nil? && subclasses.empty? && pseudo_elements.empty?
            raise MissingTokenError, "Expected compound selector to produce something"
          end

          CompoundSelector.new(type: type, subclasses: subclasses, pseudo_elements: pseudo_elements)
        end

        # <combinator> = '>' | '+' | '~' | [ '|' '|' ]
        def combinator
          options do
            maybe { consume_operator(Combinator::Child) } ||
              maybe { consume_operator(Combinator::NextSibling) } ||
              maybe { consume_operator(Combinator::SubsequentSibling) } ||
              maybe { consume_operator(Combinator::ColumnSibling) } ||
              maybe { consume_operator(Combinator::Descendant) } # must be checked last because it's whitespace
          end
        end

        # <type-selector> = <wq-name> | <ns-prefix>? '*'
        def type_selector
          options do
            maybe { wq_name } ||
              TypeSelector.new(prefix: maybe { ns_prefix }, name: consume("*"))
          end
        end

        # <ns-prefix> = [ <ident-token> | '*' ]? '|'
        def ns_prefix
          value = maybe { consume(IdentToken) } || maybe { consume("*") }
          consume("|")

          NsPrefix.new(value: value)
        end

        # <wq-name> = <ns-prefix>? <ident-token>
        def wq_name
          options do
            maybe { WqName.new(prefix: ns_prefix, name: consume(IdentToken)) } ||
              maybe { WqName.new(prefix: nil, name: consume(IdentToken)) }
          end
        end

        # <subclass-selector> = <id-selector> | <class-selector> |
        #                 <attribute-selector> | <pseudo-class-selector>
        def subclass_selector
          options do
            maybe { id_selector } ||
              maybe { class_selector } ||
              maybe { attribute_selector } ||
              maybe { pseudo_class_selector }
          end
        end

        # <id-selector> = <hash-token>
        def id_selector
          IdSelector.new(value: consume(HashToken))
        end

        # <class-selector> = '.' <ident-token>
        def class_selector
          consume(".")
          ClassSelector.new(value: consume(IdentToken))
        end

        # <attribute-selector> = '[' <wq-name> ']' |
        #                  '[' <wq-name> <attr-matcher> [ <string-token> | <ident-token> ] <attr-modifier>? ']'
        def attribute_selector
          consume(OpenSquareToken)

          name = wq_name
          matcher = maybe do
            AttributeSelectorMatcher.new(
              matcher: attr_matcher,
              value: options do
                maybe { consume(StringToken) } ||
                  maybe { consume(IdentToken) } ||
                  maybe { consume(NumberToken) }
              end,
              modifier: maybe { attr_modifier },
            )
          end

          consume(CloseSquareToken)

          AttributeSelector.new(name: name, matcher: matcher)
        end

        # <attr-matcher> = [ '~' | '|' | '^' | '$' | '*' ]? '='
        def attr_matcher
          options do
            maybe { consume_operator(AttrMatcher::Equal) } ||
              maybe { consume_operator(AttrMatcher::IncludeWord) } ||
              maybe { consume_operator(AttrMatcher::DashMatch) } ||
              maybe { consume_operator(AttrMatcher::StartWith) } ||
              maybe { consume_operator(AttrMatcher::EndWith) } ||
              maybe { consume_operator(AttrMatcher::Include) }
          end
        end

        # <attr-modifier> = i | s
        def attr_modifier
          options do
            maybe { consume_operator(AttrModifier::CaseInsensitive) } ||
              maybe { consume_operator(AttrModifier::CaseSensitive) }
          end
        end

        # <pseudo-class-selector> = ':' <ident-token> |
        #                     ':' <function-token> <any-value> ')'
        def pseudo_class_selector
          consume(ColonToken)

          case tokens.peek
          in IdentToken
            PseudoClassSelector.new(value: consume(IdentToken))
          in Function
            node = consume(Function)
            arguments = node.value.empty? ? nil : Selectors::Parser.new(node.value).parse
            function = PseudoClassFunction.new(name: node.name, arguments: arguments)
            PseudoClassSelector.new(value: function)
          else
            raise MissingTokenError, "Expected pseudo class selector to produce something"
          end
        end

        # <pseudo-element-selector> = ':' <pseudo-class-selector>
        def pseudo_element_selector
          consume(ColonToken)
          PseudoElementSelector.new(value: pseudo_class_selector)
        end

        #-------------------------------------------------------------------------
        # Helper methods
        #-------------------------------------------------------------------------

        def consume(*values)
          result =
            values.map do |value|
              case [value, tokens.peek]
              in [String, DelimToken[value: token_value]] if value == token_value
                tokens.next
              in [Class, token] if token.is_a?(value)
                tokens.next
              in [_, token]
                raise MissingTokenError, "Expected #{value} but got #{token.inspect}"
              end
            end

          result.size == 1 ? result.first : result
        end

        def consume_whitespace
          loop do
            case tokens.peek
            in CommentToken | WhitespaceToken
              tokens.next
            else
              return
            end
          end
        end

        def consume_operator(operator_class)
          if operator_class::TOKEN != WhitespaceToken
            consume_whitespace
          end
          result = consume(*operator_class::TOKEN)
          consume_whitespace

          operator_class.new(value: result)
        end

        def one_or_more
          items = []

          consume_whitespace
          items << yield

          loop do
            consume_whitespace
            if maybe { consume(CommaToken) }
              consume_whitespace
              items << yield
            else
              return items
            end
          end
        end

        def maybe
          tokens.transaction do
            yield
          rescue MissingTokenError
            raise TokenEnumerator::Rollback
          end
        end

        def options
          value = yield
          raise MissingTokenError, "Expected one of many to match" if value.nil?

          value
        end
      end

      # --------------------
      # AST nodes
      # --------------------

      # Abstract base class for nodes with one value
      class ValueNode < Node
        attr_reader :value

        def initialize(value:) # rubocop:disable Lint/MissingSuper
          @value = value
        end

        # accept(visitor) is defined in subclasses

        def child_nodes
          [value]
        end

        alias_method :deconstruct, :child_nodes

        def deconstruct_keys(keys)
          { value: value }
        end
      end

      class ComplexSelector < Node
        attr_reader :left, :combinator, :right

        def initialize(left:, combinator:, right:) # rubocop:disable Lint/MissingSuper
          @left = left
          @combinator = combinator
          @right = right
        end

        def accept(visitor)
          visitor.visit_complex_selector(self)
        end

        def child_nodes
          [left, combinator, right]
        end

        alias_method :deconstruct, :child_nodes

        def deconstruct_keys(keys)
          { left: left, combinator: combinator, right: right }
        end
      end

      class CompoundSelector < Node
        attr_reader :type, :subclasses, :pseudo_elements

        def initialize(type:, subclasses:, pseudo_elements:) # rubocop:disable Lint/MissingSuper
          @type = type
          @subclasses = subclasses
          @pseudo_elements = pseudo_elements
        end

        def accept(visitor)
          visitor.visit_compound_selector(self)
        end

        def child_nodes
          [type, subclasses, pseudo_elements].compact.flatten
        end

        alias_method :deconstruct, :child_nodes

        def deconstruct_keys(keys)
          {
            type: type,
            subclasses: subclasses,
            pseudo_elements: pseudo_elements,
          }
        end
      end

      module Combinator
        # §15.2 https://www.w3.org/TR/selectors-4/#child-combinators
        class Child < ValueNode
          TOKEN = ">"
          PP_NAME = "combinator-child"

          def accept(visitor)
            visitor.visit_combinator_child(self)
          end
        end

        # §15.1 https://www.w3.org/TR/selectors-4/#descendant-combinators
        class Descendant < ValueNode
          TOKEN = WhitespaceToken
          PP_NAME = "combinator-descendant"

          def accept(visitor)
            visitor.visit_combinator_descendant(self)
          end
        end

        # §15.3 https://www.w3.org/TR/selectors-4/#adjacent-sibling-combinators
        class NextSibling < ValueNode
          TOKEN = "+"
          PP_NAME = "combinator-next-sibling"

          def accept(visitor)
            visitor.visit_combinator_next_sibling(self)
          end
        end

        # §15.4 https://www.w3.org/TR/selectors-4/#general-sibling-combinators
        class SubsequentSibling < ValueNode
          TOKEN = "~"
          PP_NAME = "combinator-subsequent-sibling"

          def accept(visitor)
            visitor.visit_combinator_subsequent_sibling(self)
          end
        end

        # §16.1 https://www.w3.org/TR/selectors-4/#the-column-combinator
        class ColumnSibling < ValueNode
          TOKEN = ["|", "|"]
          PP_NAME = "combinator-column-sibling"

          def accept(visitor)
            visitor.visit_combinator_column_sibling(self)
          end
        end
      end

      class WqName < Node
        attr_reader :prefix, :name

        def initialize(prefix:, name:) # rubocop:disable Lint/MissingSuper
          @prefix = prefix
          @name = name
        end

        def accept(visitor)
          visitor.visit_wq_name(self)
        end

        def child_nodes
          [prefix, name]
        end

        alias_method :deconstruct, :child_nodes

        def deconstruct_keys(keys)
          { prefix: prefix, name: name }
        end
      end

      class TypeSelector < WqName
        def accept(visitor)
          visitor.visit_type_selector(self)
        end
      end

      class NsPrefix < ValueNode
        def accept(visitor)
          visitor.visit_ns_prefix(self)
        end
      end

      class IdSelector < ValueNode
        def accept(visitor)
          visitor.visit_id_selector(self)
        end
      end

      class ClassSelector < ValueNode
        def accept(visitor)
          visitor.visit_class_selector(self)
        end
      end

      class AttributeSelector < Node
        attr_reader :name, :matcher

        def initialize(name:, matcher:) # rubocop:disable Lint/MissingSuper
          @name = name
          @matcher = matcher
        end

        def accept(visitor)
          visitor.visit_attribute_selector(self)
        end

        def child_nodes
          [name, matcher]
        end

        alias_method :deconstruct, :child_nodes

        def deconstruct_keys(keys)
          { name: name, matcher: matcher }
        end
      end

      class AttributeSelectorMatcher < Node
        attr_reader :matcher, :value, :modifier

        def initialize(matcher:, value:, modifier:) # rubocop:disable Lint/MissingSuper
          @matcher = matcher
          @value = value
          @modifier = modifier
        end

        def accept(visitor)
          visitor.visit_attribute_selector_matcher(self)
        end

        def child_nodes
          [matcher, value, modifier].compact
        end

        alias_method :deconstruct, :child_nodes

        def deconstruct_keys(keys)
          { matcher: matcher, value: value, modifier: modifier }
        end
      end

      module AttrMatcher
        # §6.1 https://www.w3.org/TR/selectors-4/#attribute-representation
        class Equal < ValueNode
          TOKEN = "="
          PP_NAME = "attr-matcher-equal"

          def accept(visitor)
            visitor.visit_attr_matcher_equal(self)
          end
        end

        # §6.1 https://www.w3.org/TR/selectors-4/#attribute-representation
        class IncludeWord < ValueNode
          TOKEN = ["~", "="]
          PP_NAME = "attr-matcher-include-word"

          def accept(visitor)
            visitor.visit_attr_matcher_include_word(self)
          end
        end

        # §6.1 https://www.w3.org/TR/selectors-4/#attribute-representation
        class DashMatch < ValueNode
          TOKEN = ["|", "="]
          PP_NAME = "attr-matcher-dash-match"

          def accept(visitor)
            visitor.visit_attr_matcher_dash_match(self)
          end
        end

        # §6.2 https://www.w3.org/TR/selectors-4/#attribute-substrings
        class StartWith < ValueNode
          TOKEN = ["^", "="]
          PP_NAME = "attr-matcher-start-with"

          def accept(visitor)
            visitor.visit_attr_matcher_start_with(self)
          end
        end

        # §6.2 https://www.w3.org/TR/selectors-4/#attribute-substrings
        class EndWith < ValueNode
          TOKEN = ["$", "="]
          PP_NAME = "attr-matcher-end-with"

          def accept(visitor)
            visitor.visit_attr_matcher_end_with(self)
          end
        end

        # §6.2 https://www.w3.org/TR/selectors-4/#attribute-substrings
        class Include < ValueNode
          TOKEN = ["*", "="]
          PP_NAME = "attr-matcher-include"

          def accept(visitor)
            visitor.visit_attr_matcher_include(self)
          end
        end
      end

      module AttrModifier
        # §6.3 https://www.w3.org/TR/selectors-4/#attribute-case
        class CaseInsensitive < ValueNode
          TOKEN = "i"
          PP_NAME = "attr-modifier-case-insensitive"

          def accept(visitor)
            visitor.visit_attr_modifier_case_insensitive(self)
          end
        end

        # §6.3 https://www.w3.org/TR/selectors-4/#attribute-case
        class CaseSensitive < ValueNode
          TOKEN = "s"
          PP_NAME = "attr-modifier-case-sensitive"

          def accept(visitor)
            visitor.visit_attr_modifier_case_sensitive(self)
          end
        end
      end

      class PseudoClassSelector < ValueNode
        def accept(visitor)
          visitor.visit_pseudo_class_selector(self)
        end
      end

      class PseudoClassFunction < Node
        attr_reader :name, :arguments

        def initialize(name:, arguments:) # rubocop:disable Lint/MissingSuper
          @name = name
          @arguments = arguments
        end

        def accept(visitor)
          visitor.visit_pseudo_class_function(self)
        end

        def child_nodes
          [name, arguments]
        end

        alias_method :deconstruct, :child_nodes

        def deconstruct_keys(keys)
          { name: name, arguments: arguments }
        end
      end

      class PseudoElementSelector < ValueNode
        def accept(visitor)
          visitor.visit_pseudo_element_selector(self)
        end
      end
    end
  end
end
