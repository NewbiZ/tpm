require 'config'
require 'utils_remote.rb'
require 'utils_local.rb'

module TPM extend self
  def list( args )
    # Printing remote packages
    puts "List of remote packages:"
    list_remote_packages().each do |n|
      puts '  * ' + n
    end

    puts ""

    # Printing local packages
    puts "List of local packages:"
    list_local_packages().each do |n|
      puts '  * ' + n
    end
  end
end
