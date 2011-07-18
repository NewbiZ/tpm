# Setup some default directories
TPM_ROOT_PATH       = '/Users/newbiz/tpm'
TPM_SOURCE_PATH     = TPM_ROOT_PATH + '/source'
TPM_BUILD_PATH      = TPM_ROOT_PATH + '/build'
TPM_TEMP_PATH       = TPM_ROOT_PATH + '/tmp'
TPM_INSTALL_PATH    = TPM_ROOT_PATH + '/install'
TPM_REPOSITORY_PATH = 'file:///Users/newbiz/svn_repository/libraries/'

# Create the above directories if they are missing
Dir.mkdir TPM_ROOT_PATH    unless File.directory? TPM_ROOT_PATH
Dir.mkdir TPM_SOURCE_PATH  unless File.directory? TPM_SOURCE_PATH
Dir.mkdir TPM_BUILD_PATH   unless File.directory? TPM_BUILD_PATH
Dir.mkdir TPM_TEMP_PATH    unless File.directory? TPM_TEMP_PATH
Dir.mkdir TPM_INSTALL_PATH unless File.directory? TPM_INSTALL_PATH

# Pre create the TPM module
module TPM extend self
end

