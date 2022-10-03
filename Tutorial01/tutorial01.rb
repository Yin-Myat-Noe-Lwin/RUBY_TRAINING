COUNT = 6 

for a in 1..COUNT

  print " " * (COUNT - a) , "*" * ( ( 2 * a  ) - 1 ) , "\n"

end

#reverse loop
for b in 1..COUNT-1

  print " " * b , "*" * ( ( ( COUNT - 1 - b ) * 2 ) + 1 ) , "\n"

end
