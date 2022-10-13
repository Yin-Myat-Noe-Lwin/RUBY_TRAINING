print "Enter title:"

#user input title
title = gets.chomp

print "Enter note:"

#user input note
note = gets.chomp

print "Do you want to [save] or [cancel] ?"

choice = gets.chomp.to_s

if choice == "save"

  saved_file = "#{rand(1..100000)}.txt"

  # Creating a file
  new_file = File.new(saved_file , "w+");

  # Writing user input to the file
  new_file.write title + $/

  new_file.write note 

  # Closing a file
  new_file.close();

  begin

    #Opening the saved file
    open_file = File.open(saved_file, "r")

    # Reading the saved file
    data = open_file.read

    #Print the saved file data
    puts data

    open_file.close()
    
  rescue Exception => e

    print "file not found"

  end

end