require "apstrings/version"

module Apstrings
require 'apstrings/reader'
require 'apstrings/strings_parser'
  # Public
  def self.parse(file)
    file = read(file)
    StringsParser.new(file).parse_file
  end

  def self.read(file)
    Reader.read(file)
  end
end
