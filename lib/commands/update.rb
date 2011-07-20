require 'utils_common'

module TPM extend self
  def update_short_description
    <<-eos.unindent
    Updates local packages using the currently selected environment.
    eos
  end

  def update_long_description
    <<-eos.unindent
    Usage: tpm update PACKAGE_1 ... PACKAGE_N
    Updates the provided local packages using the currently selected environment.
    eos
  end

  def update_execute( args )
  end
end
