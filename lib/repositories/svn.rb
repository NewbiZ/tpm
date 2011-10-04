# Since ruby svn bindings are a pain to get up and working
# (that is, they cannot be provided as a gem, but rather need
# to be packaged/built and installed manually) we use the svn
# command line utility. This obviously means that you need to
# have svn in your path for this repository module to work.

require 'utils_system'

def repository_name
  "Subversion"
end

def repository_package_revision( package )
  # Issue the command
  path = File.join($tpm_config_repo_url,package)
  command = "svn info #{path}"
  res_status,res_stdout,res_stderr = system_call( command )

  # Check that there was no error
  if not res_stderr.empty? or res_status!=0
    puts 'Subversion returned the following error:'
    puts res_stderr
    puts 'While issuing the command:'
    puts command
    puts 'Remote repository revision fetch failed.'
    '?'
  end

  # Template response from svn info:
  # Path: lib1
  # URL: svn://depot/packages/lib1
  # Repository Root: svn://depot/packages/lib1
  # Repository UUID: bd218033-0bc2-44e6-bc9d-92cddc8ae144
  # Revision: 9
  # Node Kind: directory
  # Last Changed Author: user
  # Last Changed Rev: 7
  # Last Changed Date: 2011-07-19 23:55:28 +0200 (Tue, 19 Jul 2011)
  res_stdout = res_stdout.split(/$/).collect { |c| c.strip }

  # Just find the "Revision: xxx" line and return it
  res_stdout.each do |line|
    if line.start_with? 'Revision: '
      return line.gsub('Revision: ','')
    end
  end
end

def repository_real_packages_list
  # Listing result response template:
  # lib1/
  # lib2/
  # lib3/
  
  # Fetch all real folders results
  command = "svn list #{$tpm_config_repo_url}"
  res_status, res_stdout, res_stderr = system_call( command )
  
  # Catch all SVN errors here
  if not res_stderr.empty? or res_status!=0
    puts 'Subversion returned the following error:'
    puts res_stderr
    puts 'While issuing the command:'
    puts command
    puts 'Remote repository listing failed.'
    return
  end
  
  # Split the returned string in an array, and remove the
  # trailing '\' characters
  package_list = res_stdout.split
  package_list.collect { |package| package.chomp('\\').chomp('/') }
end

def repository_external_packages_list
  # External result response template:
  # lib1 file:///home/user/svn_repository/packages/lib1/trunk
  # lib2 file:///home/user/svn_repository/packages/lib2/tags/1.0.0
  # lib3 file:///home/user/svn_repository/packages/lib3/tags/rc1.1.0
end

def repository_remote_list
  # From now on, we have to parse 2 kinds of results from the SVN
  # repository: the real folders, and the externals.

  # Let's start by the real folders
  # We first retrieve them all by name
  package_list = repository_real_packages_list

  # And then we can retrieve all their revisions in the
  # current environment
  package_list.collect! do |package|
    [ package, repository_package_revision(package) ]
  end

  return package_list
end
