def repository_dir_path
  "#{TPM_LIBRARY_PATH}/repositories"
end

def repository_file_path( repository )
  "#{repository_dir_path}/#{repository}.rb"
end

def repository_require_path( repository )
  path = repository_file_path(repository)
  path.chomp(File.extname(path))
end

def repository_list
  dir = Dir.new(repository_dir_path).to_a
  # Remove filesystem artefacts
  dir.delete_if { |file| file.start_with? '.' }
  # Remove '.rb' extensions
  dir.collect! { |file| File.basename(file, File.extname(file)) }
end

def repository_exists?( repository )
  false if repository==nil or repository==''
  repository_list.include? repository
end

def repository_load( repository )
  require repository_require_path(repository)
end
