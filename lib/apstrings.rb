require "apstrings/version"

module Apstrings
require 'apstrings/reader'
require 'apstrings/strings_parser'
require 'apstrings/strings_validator'
require 'apstrings/logger'
require 'open3'

  # Public
	def self.parse(file)
    	file = Apstrings::read(file)
		StringsParser.new(file).parse_file
  	end

	def self.read(file)
		Reader.read(file)
	end

	def self.validate(file,masterFile = nil)
  
    valid_strings , valid_master = false, true
    Open3.popen3("plutil",  "-lint" ,"#{file}") {|i, o, e, t| 
        if t.value.exitstatus == 0
          valid_strings = true
        else
          valid_strings = false
          error =  e.gets
          output = o.gets
          message = (error != nil  ? error : output)
          Apstrings::log_error(" Format error in #{file}: #{message}")
        end
    }

    if masterFile != nil
        Open3.popen3("plutil",  "-lint" ,"#{masterFile}") {|i, o, e, t| 
        if t.value.exitstatus == 0
          valid_master = true
        else
          valid_master = false
          error =  e.gets
          output = o.gets
          message = (error != nil  ? error : output)
          Apstrings::log_error(" Format error in #{file}: #{message}")
        end
      }
    end

    if valid_strings && valid_master
      Validator::validate(file,masterFile)
    end
	end

  def self.log_info(message)
    Log::info(message)
  end

  def self.log_warning(message)
    Log::warn(message)
  end

  def self.log_error(message)
    Log::error(message)
  end
  	
end


