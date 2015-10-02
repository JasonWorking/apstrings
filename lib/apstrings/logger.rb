
module Apstrings
	require 'colored'
	class Log 
		def self.info(message)
			puts "INFO : #{message}".green
		end

		def self.warn(message)
			puts "WARNING: #{message}".yellow			
		end

		def self.error(message)
			puts "ERROR: #{message}".red
		end

	end
	
	
end