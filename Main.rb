require 'sqlite3'
require 'time'
require_relative 'Tools'

include Tools

db = SQLite3::Database.new "jobs.db"

db.execute "CREATE TABLE IF NOT EXISTS tableojobs (jobID INTEGER PRIMARY KEY, desc TEXT, time TEXT)"

puts "What would you like to do?"
puts "1: Work 2: delete a job 3: Delete all jobs"

menu_choice = gets.chomp

case menu_choice

when "1"
	puts "Enter the ID of the job you would like to work on."
	jobs_menu_choice = gets.chomp

	does_exist = db.execute("SELECT 1 FROM tableojobs WHERE jobID = ?", [jobs_menu_choice]).length > 0

	if does_exist != true 
		
		puts "This is your first time working this job. Please add a description"

		job_description = gets.chomp

		db.execute("INSERT INTO tableojobs VALUES ('#{jobs_menu_choice}', '#{job_description}', '')")
	end



	puts "Press enter to start the timer"
	time_array = []
	to_print = ""

	timer_count = db.execute("SELECT time FROM tableojobs WHERE jobID = ?", jobs_menu_choice)
	timer_count = timer_count.flatten
	timer_count = timer_count[0]
	timer_count = timer_count.to_i

	if timer_count == ""
		timer_count = 0
	end	

	#timer_count = 0
	timer_start = gets
	if timer_start == "\n"
		flag = false
		t = Thread.new() {
			loop do
				flag = gets
				break if flag
			end	
		}


		
		loop do 
			break if flag

			timer_count += 1
			
			time_array = to_time_format(timer_count)
						
			to_print = "#{time_array[0]}:#{time_array[1]}:#{time_array[2]} "
			print to_print + "\r"

			$stdout.flush
			
			sleep 1
		end
	end
	db.execute("UPDATE tableojobs SET time = #{timer_count} WHERE jobID = #{jobs_menu_choice} " )


when "2"


when "3"
	puts "Are you sure you want to delete all jobs?"

	jobs_menu_choice = gets.chomp
	jobs_menu_choice = jobs_menu_choice.capitalize

	puts jobs_menu_choice

	if jobs_menu_choice == 'Y'
		db.execute("DELETE FROM tableojobs")

	else
		puts "nothing was done!"
	end		

else
	puts "Not a valid choice!"
end	




