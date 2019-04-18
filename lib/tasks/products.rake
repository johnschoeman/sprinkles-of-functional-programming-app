namespace :products do
  desc "Fetch and process csvs from stfp server"
  task remote_import: :environment do
    ProcessRemoteFiles.run
  end
end
