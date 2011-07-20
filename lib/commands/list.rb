require 'config'
require 'utils_remote'
require 'utils_local'
require 'utils_common'

module TPM extend self
  def list_short_description
    <<-eos.unindent
    List remote and local packages.
    eos
  end

  def list_long_description
    <<-eos.unindent
    Usage: tpm list
    Prints out a list of all remote and local packages available
    in the currently selected environment.
    eos
  end

  def list_execute( args )
  end
end
