def command_dir_path
  "#{TPM_LIBRARY_PATH}/commands"
end

def command_file_path( command )
  "#{command_dir_path}/#{command}.rb"
end

def command_require_path( command )
  # Remove '.rb' extension
  path = command_file_path(command)
  path.chomp(File.extname(path) )
end

def command_list
  dir = Dir.new(command_dir_path).to_a
  # Remove filesystem artefacts
  dir.delete_if { |file| file.start_with? '.' }
  # Remove '.rb' extensions
  dir.collect!  { |file| File.basename(file, File.extname(file)) }
end

def command_exists?( command )
  false if command==nil or command==''
  command_list.include? command
end

def command_execute( command, args )
  require command_require_path(command)
  TPM.send "#{command}_execute", args
end

def command_short_description( command )
  require command_require_path(command)
  TPM.send "#{command}_short_description"
end

def command_long_description( command )
  require command_require_path(command)
  TPM.send "#{command}_long_description"
end

