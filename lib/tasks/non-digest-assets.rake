namespace :assets do
  desc "Create Non Digest Files"
  task non_digest_cable: :environment do
    require 'erb'

    # set destination folder & make the folder of it doesn't exist
    destination_folder      = File.join(Rails.root, "public/assets")
    Dir.mkdir(destination_folder) if !File.exist?(destination_folder)

    # check if file path is a directory
    file = Dir.glob(File.join(Rails.root, 'app/assets/javascripts/cable.js.erb')).first
    return if File.directory?(file)

    # set the final path for our rendered erb file
    destination_path = File.join(destination_folder, "cable.js")
    # read the file and using erb and save it to destination_path
    File.open(destination_path, "w+") do |f|
      f.write(ERB.new(File.read(file)).result())
    end

    # copy the the rendered erb file with an .gz extension
    FileUtils.cp(destination_path, destination_path + '.gz')
  end
end