namespace :assets do
  desc "Create Non Digest Files"
  task non_digest: :environment do
    asset_paths = Dir.glob(File.join(Rails.root, 'app/assets/javascripts/controllers/cable.js'))
    destination_path      = File.join(Rails.root, "public/assets")

    Dir.mkdir(destination_path) if !File.exist?(destination_path)

    asset_paths.each do |file|
      next if File.directory?(file)

      FileUtils.cp(file, destination_path)
      FileUtils.cp(file, File.join(destination_path, File.basename(file) + '.gz'))
    end
  end
end