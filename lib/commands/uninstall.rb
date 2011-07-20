require 'utils_local'
require 'utils_common'

module TPM extend self
  def uninstall_short_description
    <<-eos.unindent
    Uninstalls local packages for the currently selected environment.
    eos
  end

  def uninstall_long_description
    <<-eos.unindent
    Usage: tpm uninstall PACKAGE_1 ... PACKAGE_N
    Uninstalls all packages that were provided from the currently
    selected environment.
    eos
  end

  def uninstall_execute( args )
  end
end
