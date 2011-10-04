module TPM extend self
  def stage_short_description
    <<-eos.unindent
    Stages up an environment
    eos
  end

  def stage_long_description
    <<-eos.unindent
    Usage: tpm stage ENVIRONMENT
    Stages up an environment
    eos
  end

  def stage_execute
    # First, we got to determine if there is already an existing stage in place
  end

  # This only check if there is an existing stage currently in use
  def stage_exists?
  end

  # This will setup a brand new .tpmrc ready for a standard usage
  def stage_bootstrap
  end
end
