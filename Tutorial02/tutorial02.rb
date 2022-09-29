require 'date'

now= Time.now
#current date and time

cyear=now.year

cmonth=now.month

cday=now.day

print "Enter your date of birth(YYYY/MM/DD):"

input=gets.chomp
#user input

input_array=input.split '/'
#change input into array

age= cyear - input_array[0].to_i- ((cmonth > input_array[1].to_i || (cmonth == input_array[1].to_i && cday >= input_array[2].to_i)) ? 0 : 1)

if (age<18)

  puts "#{age}, child"

else

  puts "#{age}, adult"

end