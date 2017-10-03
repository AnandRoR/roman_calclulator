require_relative "roman_calculator"
require "test/unit"

class UnitTextRomanCalculator < Test::Unit::TestCase

  MAPPING = {"M"=>1000, "CM"=>900, "D"=>500, "CD"=>400, "C"=>100, "XC"=>90, "L"=>50, "XL"=>40, "X"=>10, "IX"=>9, "V"=>5, "IV"=>4, "I"=>1}
  WRONG_MAPPING = {"H"=>1000, "K"=>900, "P"=>500, "CD"=>400, "C"=>100, "XC"=>90, "L"=>50, "XL"=>40, "X"=>10, "IX"=>9, "V"=>5, "IV"=>4, "I"=>1}
  OPERATORS = ["+", "-", "*", "/"]
  WRONG_OPERATORS = ["%", "-", "*", "/"]


  #TEST CASE:- MAPPING HASH. IT SHOULD CONTAIN ROMAN LETTERS AND THIER CORESPODING VALUES
  def test_mapping_hash
    assert_equal(MAPPING, RomanMathmaticalOperation::MAPPING )
    assert_not_equal(WRONG_MAPPING, RomanMathmaticalOperation::MAPPING )
  end

  #TEST CASE:- CONSTANT OPERATORS. IT SHOULD CONTAIN ALL VALID OPERATORS
  def test_operator_array
    assert_equal(OPERATORS, RomanMathmaticalOperation::OPERATORS)
    assert_not_equal(WRONG_OPERATORS, RomanMathmaticalOperation::OPERATORS )
  end

  #TEST CASE:- to_num METHOD. IT SHOULD RETURN INTEGER VALUE IF VALID INPUT (ROMAN LETTER) PASSED ELSE RETURN 0
  def test_to_num
    assert_equal(11, RomanMathmaticalOperation.new.send(:to_num,"XI"))
    assert_equal(0, RomanMathmaticalOperation.new.send(:to_num,"wrong"))
    assert_not_equal(11, RomanMathmaticalOperation.new.send(:to_num,"X"))
  end

  #TEST CASE:- to_roman METHOD. IT SHOULD RETURN OUTPUT(ROMAN LETTERS) IF INPUT(INTEGER) PASSED ELSE RETURN BLANK STRING
  def test_to_roman
    assert_equal("X", RomanMathmaticalOperation.new.send(:to_roman,10))
    assert_not_equal("X", RomanMathmaticalOperation.new.send(:to_roman,11))
    assert_equal("", RomanMathmaticalOperation.new.send(:to_roman,0))
  end

  #TEST CASE:- valid_input METHOD. IT SHOULD RETURN nil IF VALID(ROMAN LETTERS AND OPERATORS) INPUT PASSED ELSE RAISE EXCEPTION
  def test_valid_input
    assert_equal(nil, RomanMathmaticalOperation.new("X", "+","V").send(:valid_input))
    exception = assert_raise("RomanMathmaticalOperationError") {RomanMathmaticalOperation.new("X", "+",nil).send(:valid_input)}
    assert_equal("This X or  is not valid", exception.message)
    exception = assert_raise("RomanMathmaticalOperationError") {RomanMathmaticalOperation.new("X", "%","V").send(:valid_input)}
    assert_equal("Operator missmatch", exception.message)
  end

  #TEST is_roman METHOD IT SHOULD RETURN TRUE IF VALID(ROMAN LETTER) INPUT PASSED ELSE RAISE EXCEPTION
  def test_is_roman
    assert_equal(true, RomanMathmaticalOperation.is_roman("V"))
    exception = assert_raise("RomanMathmaticalOperationError") {RomanMathmaticalOperation.is_roman(1)}
    assert_equal("Not valid input", exception.message)
    exception = assert_raise("RomanMathmaticalOperationError") {RomanMathmaticalOperation.is_roman("WRONG")}
    assert_equal("Not valid input", exception.message)
  end

  #TEST OUTPUT OF THE EXPRESSION PASSED TO THE execute_expression
  #IF VALID INPUT(ROMAN LETTERS) GIVEN IT SHOULD RETURN VALID OUTPUT(ROMAN LETTERS) ELSE RAISE EXCEPTION
  def test_execute_expression
    assert_equal("L", RomanMathmaticalOperation.new("XL","+","X").execute_expression)
    assert_equal("XCIX", RomanMathmaticalOperation.new("C","-","I").execute_expression)
    assert_equal("X", RomanMathmaticalOperation.new("C","/","X").execute_expression)
    assert_equal("C", RomanMathmaticalOperation.new("X","*","X").execute_expression)
    exception = assert_raise("RomanMathmaticalOperationError") {RomanMathmaticalOperation.new("Y","*","X").execute_expression}
    assert_equal("Not valid input", exception.message)
    exception = assert_raise("RomanMathmaticalOperationError") {RomanMathmaticalOperation.new("X","*",0).execute_expression}
    assert_equal("Not valid input", exception.message)
    exception = assert_raise("RomanMathmaticalOperationError") {RomanMathmaticalOperation.new("X", "+").execute_expression}
    assert_equal("This X or  is not valid", exception.message)
    exception = assert_raise("RomanMathmaticalOperationError") {RomanMathmaticalOperation.new("X", "%","V").execute_expression}
    assert_equal("Operator missmatch", exception.message)
  end
end
