# frozen_string_literal: true
#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.7.3
# from Racc grammar file "parser.y".
#

require 'racc/parser.rb'


require_relative "parser_extras"

module Nokogiri
  module CSS
    # :nodoc: all
    class Parser < Racc::Parser
    end
  end
end

module Nokogiri
  module CSS
    class Parser < Racc::Parser


def unescape_css_identifier(identifier)
  identifier.gsub(/\\(?:([^0-9a-fA-F])|([0-9a-fA-F]{1,6})\s?)/){ |m| $1 || [$2.hex].pack('U') }
end

def unescape_css_string(str)
  str.gsub(/\\(?:([^0-9a-fA-F])|([0-9a-fA-F]{1,6})\s?)/) do |m|
    if $1=="\n"
      ''
    else
      $1 || [$2.hex].pack('U')
    end
  end
end
##### State transition tables begin ###

racc_action_table = [
    27,    11,    64,    38,    36,    61,    62,    40,    60,    27,
    25,    98,    97,    36,    12,    48,    49,    26,    57,    25,
    28,    27,    14,    26,    30,    29,    14,    21,    23,    28,
    30,    73,    26,    36,    29,    14,    21,    23,    27,    30,
   -26,    56,    36,    12,   100,    81,    29,    27,    25,    43,
   -26,    36,    26,    92,   107,    93,    21,    25,    28,    30,
    95,    26,   -26,    29,    14,    21,    23,    28,    30,    27,
    26,    96,    29,    14,    21,    23,    27,    30,   101,    50,
    36,    53,   110,   109,   100,   111,    25,    99,   102,    56,
   103,   104,    36,    97,    29,    14,    28,    61,    65,    26,
    67,    29,    14,    21,    23,    36,    30,    36,    43,   105,
   108,    26,   112,    36,    14,    21,    23,   113,    30,    36,
   100,    43,   115,    43,    26,    36,    26,   118,    21,    43,
    21,    30,    26,    30,    36,    43,    21,   120,    26,    30,
    25,    43,    21,    36,    26,    30,   121,   122,    21,   nil,
    43,    30,   nil,    26,   nil,   nil,   nil,    21,    23,    43,
    30,   nil,    26,    89,    90,   nil,    21,   nil,   nil,    30,
   nil,   nil,    89,    90,   nil,    85,    86,    87,   nil,    88,
   nil,   nil,   nil,    84,    85,    86,    87,   nil,    88,   nil,
    61,    94,    84,    67,    61,    94,   nil,    67,    61,    94,
   nil,    67,    61,    94,   nil,    67,   nil,    14,   nil,    61,
    94,    14,    67,   nil,     4,    14,     5,    10,     4,    14,
     5,    47,   nil,   nil,   nil,     6,    14,     8,     7,     6,
   nil,     8,     7,     4,   nil,     5,    10,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,     6,   nil,     8,     7 ]

racc_action_check = [
     3,     1,    27,    11,     3,    27,    27,    14,    27,     9,
     3,    60,    60,     9,     1,    21,    24,    17,    27,     9,
     3,    30,    27,     3,    17,     3,     3,     3,     3,     9,
     3,    30,     9,    16,     9,     9,     9,     9,    12,     9,
    25,    30,    12,    71,    65,    49,    30,    46,    12,    16,
    50,    46,    16,    53,    71,    54,    16,    46,    12,    16,
    58,    12,    65,    12,    12,    12,    12,    46,    12,    26,
    46,    59,    46,    46,    46,    46,    47,    46,    62,    26,
    47,    26,    83,    83,    62,    83,    47,    61,    63,    26,
    64,    66,    28,    67,    26,    26,    47,    28,    28,    47,
    28,    47,    47,    47,    47,    31,    47,    32,    28,    68,
    82,    28,    91,    33,    28,    28,    28,    93,    28,    34,
    94,    31,    98,    32,    31,    35,    32,   101,    31,    33,
    32,    31,    33,    32,    43,    34,    33,   103,    34,    33,
    43,    35,    34,    69,    35,    34,   115,   120,    35,   nil,
    43,    35,   nil,    43,   nil,   nil,   nil,    43,    43,    69,
    43,   nil,    69,    51,    51,   nil,    69,   nil,   nil,    69,
   nil,   nil,    52,    52,   nil,    51,    51,    51,   nil,    51,
   nil,   nil,   nil,    51,    52,    52,    52,   nil,    52,   nil,
    56,    56,    52,    56,    97,    97,   nil,    97,    99,    99,
   nil,    99,   100,   100,   nil,   100,   nil,    56,   nil,   102,
   102,    97,   102,   nil,     0,    99,     0,     0,    20,   100,
    20,    20,   nil,   nil,   nil,     0,   102,     0,     0,    20,
   nil,    20,    20,    29,   nil,    29,    29,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,    29,   nil,    29,    29 ]

racc_action_pointer = [
   207,     1,   nil,    -2,   nil,   nil,   nil,   nil,   nil,     7,
   nil,     3,    36,   nil,    -5,   nil,    27,    -8,   nil,   nil,
   211,     3,   nil,   nil,   -15,     9,    67,    -6,    86,   226,
    19,    99,   101,   107,   113,   119,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   128,   nil,   nil,    45,    74,   nil,    33,
    19,   160,   169,    27,    24,   nil,   179,   nil,    36,    47,
    -1,    74,    71,    75,    78,    31,    67,    80,    85,   137,
   nil,    30,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,    84,    71,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,    86,   nil,   105,   107,   nil,   nil,   183,   115,   187,
   191,   113,   198,   130,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   132,   nil,   nil,   nil,   nil,
   133,   nil,   nil ]

racc_action_default = [
   -82,   -83,    -2,   -27,    -4,    -5,    -6,    -7,    -8,   -27,
   -81,   -83,   -27,    -3,   -83,   -10,   -54,   -12,   -15,   -16,
   -20,   -83,   -22,   -23,   -83,   -25,   -27,   -83,   -27,   -82,
   -83,   -60,   -61,   -62,   -63,   -64,   -65,   -17,   123,    -1,
    -9,   -11,   -53,   -27,   -13,   -14,   -27,   -27,   -21,   -83,
   -32,   -69,   -69,   -83,   -83,   -33,   -83,   -34,   -83,   -83,
   -43,   -44,   -45,   -46,   -83,   -25,   -83,   -43,   -83,   -78,
   -80,   -83,   -51,   -52,   -55,   -56,   -57,   -58,   -59,   -18,
   -19,   -24,   -83,   -83,   -70,   -71,   -72,   -73,   -74,   -75,
   -76,   -83,   -30,   -83,   -45,   -35,   -36,   -83,   -50,   -83,
   -83,   -83,   -83,   -83,   -37,   -77,   -79,   -38,   -28,   -66,
   -67,   -68,   -29,   -31,   -39,   -83,   -40,   -41,   -48,   -42,
   -83,   -47,   -49 ]

racc_goto_table = [
    58,    42,    13,     1,    46,    52,    19,    69,    37,    72,
    41,    39,    19,    70,    44,    19,    74,    75,    76,    77,
    78,    45,    69,    82,    91,    54,    51,    59,    70,    55,
   nil,   nil,    71,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,    79,    80,   nil,   nil,    19,
    19,   nil,   nil,   nil,   106,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   114,   nil,   116,   117,   nil,   119 ]

racc_goto_check = [
    20,    14,     2,     1,     5,    11,     7,     9,     2,    11,
    10,     2,     7,    14,    12,     7,    14,    14,    14,    14,
    14,    13,     9,    19,    19,    17,    18,    21,    14,     7,
   nil,   nil,     1,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,     2,     2,   nil,   nil,     7,
     7,   nil,   nil,   nil,    14,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    20,   nil,    20,    20,   nil,    20 ]

racc_goto_pointer = [
   nil,     3,    -1,   nil,   nil,   -16,   nil,     3,   nil,   -21,
    -6,   -21,    -3,     4,   -15,   nil,   nil,    -1,     0,   -28,
   -27,     0,   nil,   nil,   nil,   nil ]

racc_goto_default = [
   nil,   nil,   nil,     2,     3,     9,    15,    63,    20,    16,
   nil,    17,    34,    33,    18,    32,    22,    24,   nil,   nil,
    66,   nil,    31,    35,    83,    68 ]

racc_reduce_table = [
  0, 0, :racc_error,
  3, 34, :_reduce_1,
  1, 34, :_reduce_2,
  2, 34, :_reduce_3,
  1, 38, :_reduce_4,
  1, 38, :_reduce_5,
  1, 38, :_reduce_6,
  1, 38, :_reduce_7,
  1, 38, :_reduce_8,
  2, 39, :_reduce_9,
  1, 40, :_reduce_10,
  2, 41, :_reduce_11,
  1, 41, :_reduce_none,
  2, 41, :_reduce_13,
  2, 41, :_reduce_14,
  1, 41, :_reduce_15,
  1, 41, :_reduce_none,
  2, 36, :_reduce_17,
  3, 35, :_reduce_18,
  3, 35, :_reduce_19,
  1, 35, :_reduce_none,
  2, 48, :_reduce_21,
  1, 42, :_reduce_none,
  1, 42, :_reduce_23,
  3, 49, :_reduce_24,
  1, 49, :_reduce_25,
  1, 50, :_reduce_26,
  0, 50, :_reduce_none,
  4, 46, :_reduce_28,
  4, 46, :_reduce_29,
  3, 46, :_reduce_30,
  3, 51, :_reduce_31,
  1, 51, :_reduce_32,
  1, 51, :_reduce_none,
  2, 44, :_reduce_34,
  3, 44, :_reduce_35,
  3, 44, :_reduce_36,
  3, 44, :_reduce_37,
  3, 44, :_reduce_38,
  3, 53, :_reduce_39,
  3, 53, :_reduce_40,
  3, 53, :_reduce_41,
  3, 53, :_reduce_42,
  1, 53, :_reduce_none,
  1, 53, :_reduce_none,
  1, 53, :_reduce_45,
  1, 53, :_reduce_none,
  4, 54, :_reduce_47,
  3, 54, :_reduce_48,
  4, 54, :_reduce_49,
  2, 54, :_reduce_50,
  2, 45, :_reduce_51,
  2, 45, :_reduce_52,
  1, 43, :_reduce_none,
  0, 43, :_reduce_none,
  2, 47, :_reduce_55,
  2, 47, :_reduce_56,
  2, 47, :_reduce_57,
  2, 47, :_reduce_58,
  2, 47, :_reduce_59,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 47, :_reduce_none,
  1, 55, :_reduce_65,
  2, 52, :_reduce_66,
  2, 52, :_reduce_67,
  2, 52, :_reduce_68,
  0, 52, :_reduce_none,
  1, 57, :_reduce_70,
  1, 57, :_reduce_71,
  1, 57, :_reduce_72,
  1, 57, :_reduce_73,
  1, 57, :_reduce_74,
  1, 57, :_reduce_75,
  1, 57, :_reduce_76,
  3, 56, :_reduce_77,
  1, 58, :_reduce_none,
  2, 58, :_reduce_none,
  1, 58, :_reduce_none,
  1, 37, :_reduce_none,
  0, 37, :_reduce_none ]

racc_reduce_n = 83

racc_shift_n = 123

racc_token_table = {
  false => 0,
  :error => 1,
  :FUNCTION => 2,
  :INCLUDES => 3,
  :DASHMATCH => 4,
  :LBRACE => 5,
  :HASH => 6,
  :PLUS => 7,
  :MINUS => 8,
  :GREATER => 9,
  :S => 10,
  :STRING => 11,
  :IDENT => 12,
  :COMMA => 13,
  :NUMBER => 14,
  :PREFIXMATCH => 15,
  :SUFFIXMATCH => 16,
  :SUBSTRINGMATCH => 17,
  :TILDE => 18,
  :NOT_EQUAL => 19,
  :SLASH => 20,
  :DOUBLESLASH => 21,
  :NOT => 22,
  :EQUAL => 23,
  :RPAREN => 24,
  :LSQUARE => 25,
  :RSQUARE => 26,
  :HAS => 27,
  "@" => 28,
  "." => 29,
  "*" => 30,
  "|" => 31,
  ":" => 32 }

racc_nt_base = 33

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]
Ractor.make_shareable(Racc_arg) if defined?(Ractor)

Racc_token_to_s_table = [
  "$end",
  "error",
  "FUNCTION",
  "INCLUDES",
  "DASHMATCH",
  "LBRACE",
  "HASH",
  "PLUS",
  "MINUS",
  "GREATER",
  "S",
  "STRING",
  "IDENT",
  "COMMA",
  "NUMBER",
  "PREFIXMATCH",
  "SUFFIXMATCH",
  "SUBSTRINGMATCH",
  "TILDE",
  "NOT_EQUAL",
  "SLASH",
  "DOUBLESLASH",
  "NOT",
  "EQUAL",
  "RPAREN",
  "LSQUARE",
  "RSQUARE",
  "HAS",
  "\"@\"",
  "\".\"",
  "\"*\"",
  "\"|\"",
  "\":\"",
  "$start",
  "selector",
  "simple_selector_1toN",
  "prefixless_combinator_selector",
  "optional_S",
  "combinator",
  "xpath_attribute_name",
  "xpath_attribute",
  "simple_selector",
  "element_name",
  "hcap_0toN",
  "function",
  "pseudo",
  "attrib",
  "hcap_1toN",
  "class",
  "namespaced_ident",
  "namespace",
  "attrib_name",
  "attrib_val_0or1",
  "expr",
  "nth",
  "attribute_id",
  "negation",
  "eql_incl_dash",
  "negation_arg" ]
Ractor.make_shareable(Racc_token_to_s_table) if defined?(Ractor)

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

def _reduce_1(val, _values, result)
      result = [val[0], val[2]].flatten

    result
end

def _reduce_2(val, _values, result)
 result = val.flatten
    result
end

def _reduce_3(val, _values, result)
 result = [val[1]].flatten
    result
end

def _reduce_4(val, _values, result)
 result = :DIRECT_ADJACENT_SELECTOR
    result
end

def _reduce_5(val, _values, result)
 result = :CHILD_SELECTOR
    result
end

def _reduce_6(val, _values, result)
 result = :FOLLOWING_SELECTOR
    result
end

def _reduce_7(val, _values, result)
 result = :DESCENDANT_SELECTOR
    result
end

def _reduce_8(val, _values, result)
 result = :CHILD_SELECTOR
    result
end

def _reduce_9(val, _values, result)
 result = val[1]
    result
end

def _reduce_10(val, _values, result)
 result = Node.new(:ATTRIB_NAME, [val[0]])
    result
end

def _reduce_11(val, _values, result)
      result =  if val[1].nil?
                  val[0]
                else
                  Node.new(:CONDITIONAL_SELECTOR, [val[0], val[1]])
                end

    result
end

# reduce 12 omitted

def _reduce_13(val, _values, result)
 result = Node.new(:CONDITIONAL_SELECTOR, val)
    result
end

def _reduce_14(val, _values, result)
 result = Node.new(:CONDITIONAL_SELECTOR, val)
    result
end

def _reduce_15(val, _values, result)
 result = Node.new(:CONDITIONAL_SELECTOR, [Node.new(:ELEMENT_NAME, ['*']), val[0]])
    result
end

# reduce 16 omitted

def _reduce_17(val, _values, result)
 result = Node.new(val[0], [nil, val[1]])
    result
end

def _reduce_18(val, _values, result)
 result = Node.new(val[1], [val[0], val[2]])
    result
end

def _reduce_19(val, _values, result)
 result = Node.new(:DESCENDANT_SELECTOR, [val[0], val[2]])
    result
end

# reduce 20 omitted

def _reduce_21(val, _values, result)
 result = Node.new(:CLASS_CONDITION, [unescape_css_identifier(val[1])])
    result
end

# reduce 22 omitted

def _reduce_23(val, _values, result)
 result = Node.new(:ELEMENT_NAME, val)
    result
end

def _reduce_24(val, _values, result)
 result = Node.new(:ELEMENT_NAME, [[val[0], val[2]].compact.join(':')])
    result
end

def _reduce_25(val, _values, result)
      name = @namespaces.key?('xmlns') ? "xmlns:#{val[0]}" : val[0]
      result = Node.new(:ELEMENT_NAME, [name])

    result
end

def _reduce_26(val, _values, result)
 result = val[0]
    result
end

# reduce 27 omitted

def _reduce_28(val, _values, result)
      result = Node.new(:ATTRIBUTE_CONDITION, [val[1]] + (val[2] || []))

    result
end

def _reduce_29(val, _values, result)
      result = Node.new(:ATTRIBUTE_CONDITION, [val[1]] + (val[2] || []))

    result
end

def _reduce_30(val, _values, result)
      result = Node.new(:PSEUDO_CLASS, [Node.new(:FUNCTION, ['nth-child(', val[1]])])

    result
end

def _reduce_31(val, _values, result)
 result = Node.new(:ATTRIB_NAME, [[val[0], val[2]].compact.join(':')])
    result
end

def _reduce_32(val, _values, result)
 result = Node.new(:ATTRIB_NAME, [val[0]])
    result
end

# reduce 33 omitted

def _reduce_34(val, _values, result)
      result = Node.new(:FUNCTION, [val[0].strip])

    result
end

def _reduce_35(val, _values, result)
      result = Node.new(:FUNCTION, [val[0].strip, val[1]].flatten)

    result
end

def _reduce_36(val, _values, result)
      result = Node.new(:FUNCTION, [val[0].strip, val[1]].flatten)

    result
end

def _reduce_37(val, _values, result)
      result = Node.new(:FUNCTION, [val[0].strip, val[1]].flatten)

    result
end

def _reduce_38(val, _values, result)
      result = Node.new(:FUNCTION, [val[0].strip, val[1]].flatten)

    result
end

def _reduce_39(val, _values, result)
 result = [val[0], val[2]]
    result
end

def _reduce_40(val, _values, result)
 result = [val[0], val[2]]
    result
end

def _reduce_41(val, _values, result)
 result = [val[0], val[2]]
    result
end

def _reduce_42(val, _values, result)
 result = [val[0], val[2]]
    result
end

# reduce 43 omitted

# reduce 44 omitted

def _reduce_45(val, _values, result)
      case val[0]
      when 'even'
        result = Node.new(:NTH, ['2','n','+','0'])
      when 'odd'
        result = Node.new(:NTH, ['2','n','+','1'])
      when 'n'
        result = Node.new(:NTH, ['1','n','+','0'])
      else
        result = val
      end

    result
end

# reduce 46 omitted

def _reduce_47(val, _values, result)
      if val[1] == 'n'
        result = Node.new(:NTH, val)
      else
        raise Racc::ParseError, "parse error on IDENT '#{val[1]}'"
      end

    result
end

def _reduce_48(val, _values, result)
               # n+3
      if val[0] == 'n'
        val.unshift("1")
        result = Node.new(:NTH, val)
      else
        raise Racc::ParseError, "parse error on IDENT '#{val[0]}'"
      end

    result
end

def _reduce_49(val, _values, result)
         # -n+3
      if val[1] == 'n'
        val[0] = '-1'
        result = Node.new(:NTH, val)
      else
        raise Racc::ParseError, "parse error on IDENT '#{val[1]}'"
      end

    result
end

def _reduce_50(val, _values, result)
                    # 5n, -5n, 10n-1
      n = val[1]
      if n[0, 2] == 'n-'
        val[1] = 'n'
        val << "-"
        # b is contained in n as n is the string "n-b"
        val << n[2, n.size]
        result = Node.new(:NTH, val)
      elsif n == 'n'
        val << "+"
        val << "0"
        result = Node.new(:NTH, val)
      else
        raise Racc::ParseError, "parse error on IDENT '#{val[1]}'"
      end

    result
end

def _reduce_51(val, _values, result)
      result = Node.new(:PSEUDO_CLASS, [val[1]])

    result
end

def _reduce_52(val, _values, result)
 result = Node.new(:PSEUDO_CLASS, [val[1]])
    result
end

# reduce 53 omitted

# reduce 54 omitted

def _reduce_55(val, _values, result)
      result = Node.new(:COMBINATOR, val)

    result
end

def _reduce_56(val, _values, result)
      result = Node.new(:COMBINATOR, val)

    result
end

def _reduce_57(val, _values, result)
      result = Node.new(:COMBINATOR, val)

    result
end

def _reduce_58(val, _values, result)
      result = Node.new(:COMBINATOR, val)

    result
end

def _reduce_59(val, _values, result)
      result = Node.new(:COMBINATOR, val)

    result
end

# reduce 60 omitted

# reduce 61 omitted

# reduce 62 omitted

# reduce 63 omitted

# reduce 64 omitted

def _reduce_65(val, _values, result)
 result = Node.new(:ID, [unescape_css_identifier(val[0])])
    result
end

def _reduce_66(val, _values, result)
 result = [val[0], unescape_css_identifier(val[1])]
    result
end

def _reduce_67(val, _values, result)
 result = [val[0], unescape_css_string(val[1])]
    result
end

def _reduce_68(val, _values, result)
 result = [val[0], val[1]]
    result
end

# reduce 69 omitted

def _reduce_70(val, _values, result)
 result = :equal
    result
end

def _reduce_71(val, _values, result)
 result = :prefix_match
    result
end

def _reduce_72(val, _values, result)
 result = :suffix_match
    result
end

def _reduce_73(val, _values, result)
 result = :substring_match
    result
end

def _reduce_74(val, _values, result)
 result = :not_equal
    result
end

def _reduce_75(val, _values, result)
 result = :includes
    result
end

def _reduce_76(val, _values, result)
 result = :dash_match
    result
end

def _reduce_77(val, _values, result)
      result = Node.new(:NOT, [val[1]])

    result
end

# reduce 78 omitted

# reduce 79 omitted

# reduce 80 omitted

# reduce 81 omitted

# reduce 82 omitted

def _reduce_none(val, _values, result)
  val[0]
end

    end   # class Parser
  end   # module CSS
end   # module Nokogiri
