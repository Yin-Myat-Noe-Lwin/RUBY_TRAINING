choice = " "

loop do

  print "Enter first number:"

  #first number 
  first_num = gets.chomp

  #check if input number is integer or not
  is_Integer = first_num.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true

  if is_Integer == false

    puts "Your input value is not number"

    break

  end

  print "operator(+, -, *, /):"

  #operator
  op = gets.chomp

  print "Enter second number:"
  
  #second number
  sec_num = gets.chomp 

  #check input number is integer or not
  is_Integer = sec_num.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true

  if is_Integer == false

    puts "Your input value is not number"

    break

  end

  case op.to_s

  when '+'
  result = first_num.to_i + sec_num.to_i

  puts result

  when '-'
    result = first_num.to_i - sec_num.to_i

    puts result

  when '*'
    result = first_num.to_i * sec_num.to_i

    puts result

  when '/'
    result = first_num.to_i / sec_num.to_i

    puts result

  else
  puts "Invalid operator"

  end

  print "Would you like to [continue] or [stop]?"

  choice = gets.chomp.to_s

  #program will stop working if choice is stop
  break if choice == "stop"

end