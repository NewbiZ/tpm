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
    if args.empty?
      list_print_packages( 'Local packages',  list_local_packages  )
      list_print_packages( 'Remote packages', list_remote_packages )
    elsif args[0]=='local'
      list_print_packages( 'Local packages',  list_local_packages  )
    elsif args[0]=='remote'
      list_print_packages( 'Remote packages', list_remote_packages )
    else
      puts "Unknown list argument. Check usage."
    end
  end

  def list_local_packages
  end

  def list_remote_packages
    package_list = repository_remote_list
  end

  def list_print_packages( location, list )
    puts "#{location}:"
    if list==nil or list.empty?
      puts '  <none>'
    else
      list.each do |package|
        puts "  - #{package[0]} (##{package[1]})"
      end
    end
  end
end
