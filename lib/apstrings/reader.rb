module Apstrings
  require 'FileUtils'
  # Class for reading in files and returning an array of its content
  class Reader
    # Reads in a file and returns an array consisting of each line of input
    # cleaned of new line characters
    def self.read(file)
      File.open(file, 'r') do |f|
        str = f.read
        if str.bytesize >= 3 and str.getbyte(0) == 0xFF and str.getbyte(1) == 0xFE
            #UTF-16lE
            encoder = Encoding::Converter.new("UTF-16lE", "UTF-8")
            str = encoder.convert(str)
            str = str.byteslice(3, str.bytesize - 3) # 去掉FFFE
        elsif str.bytesize >= 3 and str.getbyte(0) == 0xFE and str.getbyte(1) == 0xFF
            #UTF-16bE
            encoder = Encoding::Converter.new("UTF-16bE", "UTF-8")
            str = encoder.convert(str)
            str = str.byteslice(3, str.bytesize - 3) # 去掉FEFF
        elsif str.bytesize >= 4 and str.getbyte(0) == 0xEF and str.getbyte(1) == 0xBB and str.getbyte(2) == 0xBF
            #UTF8
            str = str.byteslice(4, str.bytesize - 4) # 去掉EFBBBF
        else
            #ASCII  
            str = str.force_encoding('UTF-8')
        end
        content = str
        content.each_line.inject([]) do |content_array, line|
          line.gsub!("\n","")
          content_array.push(line)
        end
      end
    end
  end
end
