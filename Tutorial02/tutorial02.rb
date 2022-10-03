require 'date'

#current date and time
now= Time.now

current_year = now.year

current_month = now.month

current_day = now.day

print "Enter your date of birth(YYYY-MM-DD):"

#user input
input = gets.chomp

#change user input into array
input_array = input.split ("-")

#check if user input date is valid or not
if ( input_array[0].to_i <= current_year ) && ( Date.valid_date?( input_array[0].to_i , input_array[1].to_i , input_array[2].to_i ) ) 

  age = current_year - input_array[0].to_i - ( ( current_month > input_array[1].to_i || ( ( current_month == input_array[1].to_i ) && ( current_day >= input_array[2].to_i ) ) ) ? 0 : 1 )

  if ( age >= 0 && age <= 18 )

    puts "#{age}, child"

  elsif ( age > 18)

    puts "#{age}, adult"
  
  else

    puts "Please check your date of birth"

  end

else

  puts "invalid input"

end