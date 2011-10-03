require 'YAML'

def load_config
  # '/home/user' on Linux
  # 'C:/Documents And Settings/user/' on Windows
  tpm_config_home ||= ENV['HOME']
  tpm_config_home ||= ENV['USERPROFILE']
  tpm_config_file = File.join( tpm_config_home, '.tpmrc' )

  # Check that the config file is present. Fail otherwise.
  # TODO: there is a real place for enhancement here. We could for
  # instance check for a system-wide /etc/.tpmrc
  if not File.exists? tpm_config_file
    puts 'Error trying to retrieve configuration file.'
    puts 'Check that your shell contains $HOME (linux) or'
    puts '%USERPROFILE% (windows) and a file named \'.tpmrc\''
    puts 'in it, which should look like the following:'
    puts ''
    puts 'svn://depot/environments/development        -> using Subversion'
    puts 'file:///home/user/environments/development  -> using local filesystem'
    puts 'perforce:////depot/environments/development -> using Perforce'

    exit 1
  end

  conf = IO.read tpm_config_file

  # Regular expression matching:
  # <repository_type>://<repository_url>
  parsed_array = conf.scan( /(\w+):\/\/(.*)/ )

  # Check for basic .tpmrc repository URI syntax
  # We should end up with something similar to:
  # [['svn', '/depot/environments/development']]
  if ( parsed_array.size != 1 )
    puts "Configuration file #{tpm_config_file} is invalid"
    exit 1
  elsif ( parsed_array[0].size != 2 )
    puts "Configuration file #{tpm_config_file} is invalid"
    exit 1
  end

  $tpm_config_repo_type = parsed_array[0][0]
  $tpm_config_repo_url  = parsed_array[0][1]

  # Check for config file sanity
  if not ['file','svn','perforce'].include? $tpm_config_repo_type
    puts "Unsupported repository type '#{$tpm_config_repo_type}'."
    puts "Currently TPM only supports 'file', 'svn' or 'perforce'."
    puts "Check your configuration file #{tpm_config_file} and stage again."
    exit 1
  end

  # Create some handy config variables
  $tpm_config_root_path    = File.join( tpm_config_home,       '.tpm'    )
  $tpm_config_source_path  = File.join( $tpm_config_root_path, 'source'  )
  $tpm_config_build_path   = File.join( $tpm_config_root_path, 'build'   )
  $tpm_config_install_path = File.join( $tpm_config_root_path, 'install' )

  # Create the above directories if they are missing
  begin
    Dir.mkdir $tpm_config_root_path    unless File.directory? $tpm_config_root_path
    Dir.mkdir $tpm_config_source_path  unless File.directory? $tpm_config_source_path
    Dir.mkdir $tpm_config_build_path   unless File.directory? $tpm_config_build_path
    Dir.mkdir $tpm_config_install_path unless File.directory? $tpm_config_install_path
  rescue SystemCallError
    puts "Error accessing root path #{$tpm_config_root_path}."
    puts "TPM needs read and write permissions on this directory."
    exit 1
  end

  #@DEBUG@
  #puts "$tpm_config_repo_type:    #{$tpm_config_repo_type}"
  #puts "$tpm_config_repo_url:     #{$tpm_config_repo_url}"
  #puts "$tpm_config_root_path:    #{$tpm_config_root_path}"
  #puts "$tpm_config_source_path:  #{$tpm_config_source_path}"
  #puts "$tpm_config_build_path:   #{$tpm_config_build_path}"
  #puts "$tpm_config_install_path: #{$tpm_config_install_path}"
  #@DEBUG@
end

# Pre create the TPM module
module TPM extend self
end

