choice="continue"

while choice=="continue"

  print "Enter first number:"

  first_num = gets.chomp
  #first number 

  is_Integer = first_num.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  #check if input number is integer or not

  break if is_Integer==false

  print "operator(+, -, *, /):"

  op = gets.chomp
  #operator

  print "Enter second number:"
  
  sec_num = gets.chomp
  #second number 

  is_Integer = sec_num.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  #check input number is integer or not

  break if is_Integer==false

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
  #case operator

  print "Would you like to [continue] or [stop]?"

  choice=gets.chomp.to_s

  break if choice=="stop"
  #program will stop working if choice is stop

end
#loop until choice is continue