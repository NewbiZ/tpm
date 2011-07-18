require 'utils_local.rb'

module TPM extend self
  def uninstall( args )
    if args.empty?
      puts "No package name provided."
      return
    end

    args.each do |package|
      if not exists_local_package?(package)
        puts "Package \"#{package}\" is not currently installed."
        next
      end

      if not uninstall_local_package(package)
        puts "Error uninstalling \"#{package}\"."
        next
      end

      puts "Successfully uninstalled package \"#{package}\"."
    end
  end
end
