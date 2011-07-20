require 'utils_common'

module TPM extend self
  def search_short_description
    <<-eos.unindent
    Search for remote or local packages based on their name.
    eos
  end

  def search_long_description
    <<-eos.unindent
    Usage: tpm search PACKAGE
    Displays a list of all packages whose name matches the
    provided pattern.
    eos
  end

  def search_execute( args )
  end
end
