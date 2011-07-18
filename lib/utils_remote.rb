require 'config'

def list_remote_packages
  `svn list #{TPM_REPOSITORY_PATH}`.split.collect! { |n| n.chop }
end

def info_remote_package( package_name )
  return package_name
end

def exists_remote_package?( package_name )
  list_remote_packages().include? package_name
end

def checkout_remote_package( package_name )
  if not exists_remote_package?(package_name)
    return false
  end

  `svn checkout #{TPM_REPOSITORY_PATH}/#{package_name} #{TPM_SOURCE_PATH}/#{package_name}`

  return true
end

