array_limit = 10
#limit

print "Enter your array length:"

arr_length = gets.chomp.to_i
#user input array length

print "Enter animal name into array:"

animal_array = []
#array

input = ' '
 
for i in 1..arr_length do
     
  input = gets.chomp
  #animal name input

  animal_array.push input

  puts "Array Length: #{animal_array.length}"
  #animal_array length

  if (animal_array.length == array_limit)

    puts "Sorted Array:" + animal_array.sort.to_s
    #sorted animal_array

    puts "Duplicate value removed:"+ animal_array.uniq.to_s
    #remove duplicate value in animal_array

    puts "Reversed Array:" + animal_array.reverse.to_s
    #reversed animal_array

    break

  end
   
end