require 'popen4'

def system_call( command )
  result_status = ""
  result_stdout = ""
  result_stderr = ""
  result_status = POpen4::popen4( command ) do |stdout,stderr,stdin,pid|
    result_stderr = stderr.read.strip
    result_stdout = stdout.read.strip
  end
  return result_status.exitstatus, result_stdout, result_stderr
end

def write_log( file_path, status, stdout, stderr )
  File.open( file_path, 'w' ) do |f|
    f.write "--- LOG GENERATED AT #{Time.now}\n"
    f.write "--- EXIT STATUS: #{status}\n"
    f.write "--- STDOUT\n"
    f.write stdout
    f.write "\n--- STDERR\n"
    f.write stderr
  end
  puts "Log file saved to #{file_path}."
end
