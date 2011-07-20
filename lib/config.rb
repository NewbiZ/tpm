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
    puts '  repo_url:  file:///var/svn_repository'
    puts '  root_path: /home/user/.tpmrc'
    puts '  repo_type: svn'

    exit 1
  end

  # Add '---' in head of file content for it to be considered
  # as YAML
  conf = IO.read tpm_config_file
  conf = "--- \n" + conf

  tpm_config = YAML.parse(conf)

  # Check for config file sanity
  if tpm_config['root_path']==nil
    puts "Config file #{tpm_config_file} missing 'root_path'."
    exit 1
  elsif tpm_config['repo_url']==nil
    puts "Config file #{tpm_config_file} missing 'repo_url'."
    exit 1
  elsif tpm_config['repo_type']==nil
    puts "Config file #{tpm_config_file} missing 'repo_type'."
    exit 1
  end

  # Create some handy config variables
  $tpm_config_root_path    = tpm_config['root_path'].value
  $tpm_config_source_path  = File.join( $tpm_config_root_path, 'source'  )
  $tpm_config_build_path   = File.join( $tpm_config_root_path, 'build'   )
  $tpm_config_install_path = File.join( $tpm_config_root_path, 'install' )
  $tpm_config_repo_url     = tpm_config['repo_url' ].value
  $tpm_config_repo_type    = tpm_config['repo_type'].value

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
end

# Pre create the TPM module
module TPM extend self
end

