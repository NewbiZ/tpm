require 'utils_remote'
require 'utils_common'
require 'utils_local'

module TPM extend self
  def install_short_description
    <<-eos.unindent
    Installs a package on the local selected environment.
    eos
  end

  def install_long_description
    <<-eos.unindent
    Usage: tpm install PACKAGE_1 ... PACKAGE_N
    Installs all the specified packages on the local selected
    environment.
    eos
  end

  def install_execute( args )
  end
end

