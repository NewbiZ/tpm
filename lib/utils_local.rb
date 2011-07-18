require 'config'
require 'utils_system'
require 'FileUtils'

def list_local_packages
  # Care to remove '.', '..' and all '.(.*)' folders
  Dir.new(TPM_SOURCE_PATH).to_a.delete_if do |n|
    n.start_with? '.'
  end
end

def info_local_package( package_name )
  return package_name
end

def exists_local_package?( package_name )
  list_local_packages().include? package_name
end

def build_local_package( package_name )
  build_path   = "#{TPM_BUILD_PATH}/#{package_name}"
  source_path  = "#{TPM_SOURCE_PATH}/#{package_name}"
  install_path = "#{TPM_INSTALL_PATH}/#{package_name}"

  # Prepare a clean build directory
  if File.directory? build_path
    puts "Removing existing directory #{build_path}."
    FileUtils.rm_rf build_path
  end

  # Configure the package (calling cmake)
  Dir.mkdir build_path
  Dir.chdir build_path do
    puts "Configuring package #{package_name}."

    # Call cmake
    status, stdout, stderr = system_call "cmake -DCMAKE_INSTALL_PREFIX=#{install_path} #{source_path}"
    
    # Save the configuration log
    write_log( build_path+'/configuration.log', status, stdout, stderr )

    # Any error configuring the project?
    if not status==0
      puts "Error configuring package \"#{package_name}\". See log file for more information"
      return false
    end

    # Now build the project
    status, stdout, stderr = system_call( "make" )

    # Save the build log
    write_log( build_path+'/build.log', status, stdout, stderr )

    if not status==0
      puts "Error building package \"#{package_name}\". See log file for more information."
      return false
    end

    true
  end
end

def install_local_package( package_name )
  build_path   = "#{TPM_BUILD_PATH}/#{package_name}"
  install_path = "#{TPM_INSTALL_PATH}/#{package_name}"

  # Prepare a clean install directory
  if File.directory? install_path
    puts "Removing existing directory #{install_path}."
    FileUtils.rm_rf install_path
  end

  # Install the package
  Dir.mkdir install_path
  Dir.chdir build_path do
    status, stdout, stderr = system_call( "make install" )
  
    # Save the install log
    write_log( build_path+'/install.log', status, stdout, stderr )

    if not status==0
      puts "Error installing package \"#{package_name}\". See log file for more information."
      return false
    end
  end

  true
end

def uninstall_local_package( package_name )
  build_path       = "#{TPM_BUILD_PATH}/#{package_name}"
  source_path      = "#{TPM_SOURCE_PATH}/#{package_name}"
  install_path     = "#{TPM_INSTALL_PATH}/#{package_name}"
  install_manifest = build_path + '/install_manifest.txt'

  if not File.directory? build_path
    puts "Error finding build directory #{build_path}."
    return false
  end

  if not File.exists? install_manifest
    puts "Error finding install manifest file #{install_manifest}."
    return false
  end

  File.open( install_manifest ) do |f|
    f.each_line do |installed_file|
      installed_file.chomp!
      if File.exists? installed_file
        File.delete installed_file
        puts "Removing #{installed_file}."
      else
        puts "Cannot find file to remove #{installed_file}."
      end
    end
  end

  puts "Removing build directory #{build_path}."
  FileUtils.rm_rf build_path
  
  if not File.directory? source_path
    puts "Error finding source directory #{source_path}."
    return false
  end

  puts "Removing source directory #{source_path}."
  FileUtils.rm_rf source_path

  true
end

