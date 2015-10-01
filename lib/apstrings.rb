require "apstrings/version"

module Apstrings
require 'apstrings/reader'
require 'apstrings/strings_parser'
require 'apstrings/strings_validator'

  # Public
	def self.parse(file)
    	file = Apstrings::read(file)
		StringsParser.new(file).parse_file
  	end

	def self.read(file)
		Reader.read(file)
	end

  	def self.validate(file,masterFile = nil)
  		Validator::validate(file,masterFile)
  	end
  	
end


