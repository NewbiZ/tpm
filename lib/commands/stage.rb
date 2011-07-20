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
  end
end
