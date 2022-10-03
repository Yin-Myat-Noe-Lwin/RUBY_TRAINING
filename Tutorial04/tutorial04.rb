array_limit = 10

print "Enter your array length:"

#user input array length
arr_length = gets.chomp.to_i

#animal_array
animal_array = []

input = ' '

(arr_length < array_limit )? (array_limit = arr_length) : array_limit
 
for i in 1..array_limit do
     
  print "Enter animal name into array:"
  
  #animal name input
  input = gets.chomp

  animal_array.push input

  if (animal_array.length == array_limit)

    sorted_array = []

    sorted_array = animal_array.sort

    #sorted animal_array
    puts "Sorted Array:" + sorted_array.to_s

    #remove duplicate value in animal_array
    puts "Duplicate value removed:"+ sorted_array.uniq.to_s

    #reversed animal_array
    puts "Reversed Array:" + sorted_array.reverse.to_s

    break

  end
   
end