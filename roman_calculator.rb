class RomanMathmaticalOperationError < Exception; end

class RomanMathmaticalOperation
  
  MAPPING = {"M"=>1000, "CM"=>900, "D"=>500, "CD"=>400, "C"=>100, "XC"=>90, "L"=>50, "XL"=>40, "X"=>10, "IX"=>9, "V"=>5, "IV"=>4, "I"=>1}
  OPERATORS = ["+", "-", "*", "/"]

  attr_accessor :operand_one, :operand_two, :operator

  def initialize(operand_one=nil, operator=nil, operand_two=nil)
    @operand_one = operand_one
    @operand_two = operand_two
    @operator = operator
  end

  #INPUT:- THIS IS AN INSTANCE METHOD. CALL IT TO EXECUTE GIVEN EXPRESSION.
  #FUNCTION:- IT WILL CHECK FOR INPUT. IT SHOULD BE STRING AND SHOULD BE VALID ROMAN LETTER AND THEN WILL CALL THE METHOD
  #           DYNAMICALY AND EXECUTE THE EXPRESSION 
  #OUTPUT:- IT RETURN'S ROMAN LETTER IF VALID INPUT PASSED ELSE RAISE EXCEPTION
  def execute_expression
    valid_input
    to_roman(to_num(@operand_one).send(@operator, to_num(@operand_two)))
  end

  #INPUT:- THIS IS A CLASS METHOD. THIS TAKES AN ARGUMENT AS STRING VALUE.
  #FUNCTION:- IT WILL CHECK FOR INPUT. IT SHOULD BE STRING AND SHOULD BE VALID ROMAN LETTER.
  #OUTPUT:- IT RETURN'S true IF VALID INPUT PASSED ELSE RAISE EXCEPTION
  def self.is_roman(value)
    unless value.class == String
      raise RomanMathmaticalOperationError, "Not valid input"
    end
    unless (MAPPING.keys & value.split('')).length == value.length
      raise RomanMathmaticalOperationError, "Not valid input"
    end
    true
  end

  private

  #INPUT:- THIS IS A PRIVATE METHOD. IT TAKES AN ARGUMENT AS STRING VALUE.
  #FUNCTION:- IT WILL ITERATE OVER MAPPING HASH AND WILL CONVERT THE ROMAN LETTE INTO IT'S CORRESPONDING INTEGER VALUE.
  #OUTPUT:- IT RETURN'S INTEGER VALUE IF VALID INPUT PASSED ELSE 0
  def to_num(input)
    result = 0
    #iterate on roman number hash
    MAPPING.each do |k,v|
      while input.index(k) == 0 #if "CL".index("C") == 0
        result += v #assign value of current hash key
        input.slice!(0) #remove string "C" from input and so on
      end
    end
    result
  end

  #INPUT:- THIS IS A PRIVATE METHOD. IT TAKES AN ARGUMENT AS INTEGER VALUE.
  #FUNCTION:- IT WILL ITERATE OVER MAPPING HASH AND WILL CONVERT THE INTEGER VALUE INTO IT'S CORRESPONDING ROMAN VALUE.
  #OUTPUT:- IT RETURN'S ROMAN LETTER IF VALID INPUT PASSED ELSE BLANK STRING
  def to_roman(input)
    result = ""
    MAPPING.each do |k,v|
      while input%v < input
        result += k
        input -= v
      end
    end
    result
  end

  #INPUT:- THIS IS A PRIVATE METHOD. THIS CAN BE CALL ONLY IN CONTXT OF CURRENT OBJECT.
  #FUNCTION:- IT WILL VALIDATE THE INPUT PASSED BY USER.
  #OUTPUT:- IT WILL RAISE AN EXCEPTION IF ANY INPUT IS INVALID ELSE IT WILL RETURN nil
  def valid_input
    if !@operand_one or !@operand_two or !RomanMathmaticalOperation.is_roman(@operand_one) or !RomanMathmaticalOperation.is_roman(@operand_two)
      raise RomanMathmaticalOperationError, "This #{@operand_one} or #{@operand_two} is not valid"
    end

    unless OPERATORS.include?(@operator)
      raise RomanMathmaticalOperationError, "Operator missmatch"
    end
  end
end

class_instance = RomanMathmaticalOperation.new("V", "+", "V")
begin
  p class_instance.execute_expression
rescue RomanMathmaticalOperationError => e
  p e.message
end
