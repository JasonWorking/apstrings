module Apstrings
	require 'apstrings/reader'
	require 'apstrings/strings_parser'
	require 'apstrings/logger'

	class Validator

		def self.validate(file,masterFile)
			@master = nil
			puts "apstrings: start validate  strings file  ..."
			if nil == masterFile
				Log::warn("No master file provided, validating file format for #{file} only ...")
			else
				@master = Validator::paredFile(masterFile)
			end

			valid_master, valid_file , no_missing_key  = true,true,true

			valid_file = Validator::validate_format(file)
			if masterFile != nil
				valid_master = Validator::validate_format(masterFile)
				no_missing_key = Validator::validate_missing(file,masterFile)
			end
			
			if valid_master && valid_file &&  no_missing_key
				Log::info("Yeah! 🍻 🍻 ")
				return true
			else
				Log::error("Oh no! Invalid file.")
				return false
			end
		end

		def self.validate_format(file)
			is_valid = true
			puts "apstrings: start validate format for #{file} ..."
			dup_keys_in_file = Validator::validate_duplicates(file)
			mismatchs_in_file = Validator::validate_special_characters(file)
			if nil != dup_keys_in_file && !dup_keys_in_file.empty?
				Log::warn("Dup-keys found in #{file}: \n `#{dup_keys_in_file}`.")
			else
				# Log::info("OK . .")
			end

			if !mismatchs_in_file.empty?
				is_valid = false
				mismatchs_in_file.each { |e| e.each_pair {
						|key,value|
						Log::error("Mismatch format found in `#{file}`: \n `#{key}` ====>  `#{value}`")
					}
				}
			else
				# Log::info("OK ...  \n ")
			end
			is_valid
		end

		def self.validate_missing(file,masterFile)
			puts "apstrings: checking missing keys for #{file}..."
			sf = Validator::paredFile(file)
			sf_masterFile = Validator::paredFile(masterFile)
			no_missing = true
			missing_keys = sf_masterFile.keys - sf.keys
			if !missing_keys.empty?
				no_missing =false
				Log::warn("#{missing_keys.count.to_s} missing keys found in #{file} comparing to master file: #{masterFile} : \n #{missing_keys.to_s}")
			else
				# Log::info("OK...")
			end
			no_missing
		end

		def self.validate_duplicates(file)
			puts "apstrings: checking dup-keys for #{file}..."
			sf = Validator::paredFile(file)
			sf.keys.detect {
				|e| sf.keys.count(e) > 1
			}
		end


		def self.validate_special_characters(file)
			puts "apstrings: checking syntax for #{file}..."
			sf = Validator::paredFile(file)
			variables_regex = /%[hlqLztj]?[@%dDuUxXoOfeEgGcCsSpaAF]/
			mismatchs = []
			sf.key_values.each {
				|e|  e.each_pair {
					|key,value|	
					fixed_key = Validator::value_in_master(key)	
					striped_key =  fixed_key.gsub(/%\d\$/,'%') # Strip numbered format placeholders , e.g. %1$@ --> %@ 
					striped_value = value.gsub(/%\d\$/,'%')   
					key_variables = striped_key.scan(variables_regex) 
					value_variables = striped_value.scan(variables_regex) 
					if !(key_variables.sort == value_variables.sort)
						mismatchs << {key => value}   
					end
				}
			}
			mismatchs
		end

		def self.paredFile(file)
			file = Reader.read(file)
			StringsParser.new(file).parse_file
		end

		def self.value_in_master(key)
			if @master
				value_comment = @master.to_hash[key] # 
				if value_comment == nil
					return key 
				else
					return value_comment.keys[0]
				end
			else
				key
			end
		end

	end
	
end
