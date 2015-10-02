
require 'apstrings'



$ROOT = "/Users/Jason/Desktop/clean-portal/Portal/Pods/APCommonUI/APCommonUI.framework"

Dir::chdir($ROOT)
files_to_validate = {"master"=> nil,"files" => []}
Dir.glob(File.join("**", "*.bundle","**","*.strings")) { |file| 
	p File.basename(file)
	if File.basename(file) == "zh-Hans.strings"
		files_to_validate["master"] = File.expand_path(file)
	else
		files_to_validate["files"] << File.expand_path(file) 
	end
 }

success = true
files_to_validate["files"].each { |file|
	if !Apstrings::validate(file,files_to_validate["master"])
		success = false
	end
 }

 p success ? Apstrings::log_info("Success, well done!") :  Apstrings::log_error("Failed: You'd better know what r u doing...")