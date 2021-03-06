module Apstrings
    require 'apstrings/line'
    require 'apstrings/kv_pair'
    require 'apstrings/dot_string_file'
    class StringsParser
        KEY = "KEY"
        COMMENT = "COMMENT"
        
        def initialize(read_file, parsed_file = DotStringFile.new)
            @read_file = read_file
            @parsed_file = parsed_file
        end
        
        def parse_file
            state = KEY
            current_comment = nil
            comments_for_keys = {}
            @read_file.each do |content_line|
                current_line = Line.new(content_line)
                next if current_line.empty_line? && current_line.in_comment == false
                
                #State machine
                case state
                    when KEY
                    if current_line.whole_comment?
                        unless current_line.whole_comment.strip == 'No comment provided by engineer.'
                            current_comment = current_line.whole_comment
                        end
                        elsif current_line.key_value_pair? && current_comment
                        comments_for_keys[current_line.key] = current_comment
                        current_comment = nil
                        elsif current_line.open_comment?
                        current_comment = current_line.open_comment + "\n"
                        state = COMMENT
                    end
                    when COMMENT
                    if current_line.close_comment?
                        current_comment += current_line.close_comment
                        state = KEY
                        else
                        current_line.in_comment = true
                        current_comment = current_comment + current_line.content + "\n"
                    end
                end
                
                unless current_line.is_comment?
                    @parsed_file.kv_pairs << KVPair.new(current_line, comments_for_keys[current_line.key])
                end
            end
            
            raise "Invalid .string file: Unterminated comment" unless state == KEY
            @parsed_file
        end
    end
end
