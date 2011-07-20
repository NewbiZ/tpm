require 'utils_commands'
require 'utils_common'

module TPM extend self
  def help_short_description
    <<-eos.unindent
    Provides detailed information on commands.
    eos
  end

  def help_long_description
    <<-eos.unindent
    Usage: tpm help COMMAND OPTS...
    Provides details help on the specified command.
    eos
  end

  def help_execute( args )
    if args.empty?
      args = ['help']
    end
    
    args.each do |command|
      if command_exists? command
        puts command_long_description(command)
      else
        puts "Unknow command '#{command}'."
      end
    end
  end
end
