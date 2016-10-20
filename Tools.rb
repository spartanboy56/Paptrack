require 'sqlite3'
require 'time'

module Tools

def to_time_format(raw_time)

hours = raw_time / (60 * 60)
minutes = (raw_time / 60) % 60
seconds = raw_time % 60
time_elapsed = [hours,minutes,seconds]

end





end	