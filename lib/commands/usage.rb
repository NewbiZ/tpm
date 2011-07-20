require 'utils_commands'
require 'utils_common'

module TPM extend self
  def usage_short_description
    <<-eos.unindent
    Provides information on the available commands.
    eos
  end

  def usage_long_description
    <<-eos.unindent
    Usage: tpm usage
    Provides information on the available commands.
    eos
  end

  def usage_execute( args )
    puts 'Usage: tpm COMMAND ARGS...'
    puts ''
    puts 'Available commands:'
    command_list.each do |command|
      puts "  - #{command}: #{command_short_description(command)}"
    end
  end
end
