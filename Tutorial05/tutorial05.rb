require 'time'

require 'date'

#current_day
current_day = Date.today

#last 5 days before current day
puts (1..5).map{ |n| Date::ABBR_DAYNAMES[ (current_day - n).wday ]   }