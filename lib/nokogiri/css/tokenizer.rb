# frozen_string_literal: true
#--
# DO NOT MODIFY!!!!
# This file is automatically generated by rex 1.0.7
# from lexical definition file "lib/nokogiri/css/tokenizer.rex".
#++

module Nokogiri
module CSS
# :nodoc: all
class Tokenizer
      require 'strscan'

      class ScanError < StandardError ; end

      attr_reader   :lineno
      attr_reader   :filename
      attr_accessor :state

      def scan_setup(str)
        @ss = StringScanner.new(str)
        @lineno =  1
        @state  = nil
      end

      def action
        yield
      end

      def scan_str(str)
        scan_setup(str)
        do_parse
      end
      alias :scan :scan_str

      def load_file( filename )
        @filename = filename
        File.open(filename, "r") do |f|
          scan_setup(f.read)
        end
      end

      def scan_file( filename )
        load_file(filename)
        do_parse
      end


        def next_token
          return if @ss.eos?

          # skips empty actions
          until token = _next_token or @ss.eos?; end
          token
        end

        def _next_token
          text = @ss.peek(1)
          @lineno  +=  1  if text == "\n"
          token = case @state
            when nil
          case
                  when (text = @ss.scan(/has\([\s]*/))
                     action { [:HAS, text] }

                  when (text = @ss.scan(/([_A-Za-z]|[^\0-\177]|(\\[0-9A-Fa-f]{1,6}(\r\n|[\s])?|\\[^\n\r\f0-9A-Fa-f]))([_A-Za-z0-9-]|[^\0-\177]|(\\[0-9A-Fa-f]{1,6}(\r\n|[\s])?|\\[^\n\r\f0-9A-Fa-f]))*\([\s]*/))
                     action { [:FUNCTION, text] }

                  when (text = @ss.scan(/([_A-Za-z]|[^\0-\177]|(\\[0-9A-Fa-f]{1,6}(\r\n|[\s])?|\\[^\n\r\f0-9A-Fa-f]))([_A-Za-z0-9-]|[^\0-\177]|(\\[0-9A-Fa-f]{1,6}(\r\n|[\s])?|\\[^\n\r\f0-9A-Fa-f]))*/))
                     action { [:IDENT, text] }

                  when (text = @ss.scan(/\#([_A-Za-z0-9-]|[^\0-\177]|(\\[0-9A-Fa-f]{1,6}(\r\n|[\s])?|\\[^\n\r\f0-9A-Fa-f]))+/))
                     action { [:HASH, text] }

                  when (text = @ss.scan(/[\s]*~=[\s]*/))
                     action { [:INCLUDES, text] }

                  when (text = @ss.scan(/[\s]*\|=[\s]*/))
                     action { [:DASHMATCH, text] }

                  when (text = @ss.scan(/[\s]*\^=[\s]*/))
                     action { [:PREFIXMATCH, text] }

                  when (text = @ss.scan(/[\s]*\$=[\s]*/))
                     action { [:SUFFIXMATCH, text] }

                  when (text = @ss.scan(/[\s]*\*=[\s]*/))
                     action { [:SUBSTRINGMATCH, text] }

                  when (text = @ss.scan(/[\s]*!=[\s]*/))
                     action { [:NOT_EQUAL, text] }

                  when (text = @ss.scan(/[\s]*=[\s]*/))
                     action { [:EQUAL, text] }

                  when (text = @ss.scan(/[\s]*\)/))
                     action { [:RPAREN, text] }

                  when (text = @ss.scan(/\[[\s]*/))
                     action { [:LSQUARE, text] }

                  when (text = @ss.scan(/[\s]*\]/))
                     action { [:RSQUARE, text] }

                  when (text = @ss.scan(/[\s]*\+[\s]*/))
                     action { [:PLUS, text] }

                  when (text = @ss.scan(/[\s]*>[\s]*/))
                     action { [:GREATER, text] }

                  when (text = @ss.scan(/[\s]*,[\s]*/))
                     action { [:COMMA, text] }

                  when (text = @ss.scan(/[\s]*~[\s]*/))
                     action { [:TILDE, text] }

                  when (text = @ss.scan(/\:not\([\s]*/))
                     action { [:NOT, text] }

                  when (text = @ss.scan(/-?([0-9]+|[0-9]*\.[0-9]+)/))
                     action { [:NUMBER, text] }

                  when (text = @ss.scan(/[\s]*\-[\s]*/))
                     action { [:MINUS, text] }

                  when (text = @ss.scan(/[\s]*\/\/[\s]*/))
                     action { [:DOUBLESLASH, text] }

                  when (text = @ss.scan(/[\s]*\/[\s]*/))
                     action { [:SLASH, text] }

                  when (text = @ss.scan(/U\+[0-9a-f?]{1,6}(-[0-9a-f]{1,6})?/))
                     action {[:UNICODE_RANGE, text] }

                  when (text = @ss.scan(/[\s]+/))
                     action { [:S, text] }

                  when (text = @ss.scan(/("([^\n\r\f"]|(\n|\r\n|\r|\f)|[^\0-\177]|(\\[0-9A-Fa-f]{1,6}(\r\n|[\s])?|\\[^\n\r\f0-9A-Fa-f]))*(?<!\\)(?:\\{2})*"|'([^\n\r\f']|(\n|\r\n|\r|\f)|[^\0-\177]|(\\[0-9A-Fa-f]{1,6}(\r\n|[\s])?|\\[^\n\r\f0-9A-Fa-f]))*(?<!\\)(?:\\{2})*')/))
                     action { [:STRING, text] }

                  when (text = @ss.scan(/./))
                     action { [text, text] }

          
          else
            text = @ss.string[@ss.pos .. -1]
            raise  ScanError, "can not match: '" + text + "'"
          end  # if

        else
          raise  ScanError, "undefined state: '" + state.to_s + "'"
        end  # case state
          token
        end  # def _next_token

end # class
end
end
