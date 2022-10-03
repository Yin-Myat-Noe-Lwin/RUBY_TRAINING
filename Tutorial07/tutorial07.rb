#Person class
class Person

  attr_accessor :name
  
  def initialize(name)

    @name = name

  end

  def print_name

    puts @name

  end
  
end
  
#Student class
class Student < Person

  attr_accessor :roll_number

  def initialize(name , roll_number)

    @name = name
    
    @roll_number = roll_number

  end
  
  def print_roll

    puts @roll_number

  end
  
  end
  
  print "Choose [Person] or [Student]:"

  choice = gets.chomp.to_s
  
case choice
  
  when 'Person'
  
    print "Enter your name:"
  
    name = gets.chomp.to_s
  
     #Create person object
     p = Person.new(name)
  
     p.print_name
  
  when 'Student'
  
    print "Enter your name:"
  
    name = gets.chomp.to_s
  
    print "Enter your roll number:"
  
    roll_number = gets.chomp.to_s
  
    #Create student object
    s = Student.new(name, roll_number)
    
    s.print_name
    
    s.print_roll
  else
  
    puts "Invalid input"
  
  end