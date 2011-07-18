require 'utils_remote.rb'
require 'utils_local.rb'

module TPM extend self
  def install( args )
    if args.empty?
      puts 'No package name provided.'
      return
    end

    args.each do |package|
      if exists_local_package?(package)
        puts "Package \"#{package}\" already exists. Try the 'update' command."
        next
      end

      if not exists_remote_package?(package)
        puts "Package \"#{package}\" does not exists."
        next
      end

      if not checkout_remote_package(package)
        puts "Error checking out \"#{package}\"."
        next
      end

      if not build_local_package(package)
        puts "Error building \"#{package}\"."
        next
      end

      if not install_local_package(package)
        puts "Error installing \"#{package}\"."
        next
      end

      puts "Successfully installed package \"#{package}\"."
    end
  end
end

