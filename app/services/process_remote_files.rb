# frozen_string_literal: true
require "net/sftp"

class ProcessRemoteFiles
  SFTP_PATH = ENV.fetch("SFTP_PATH")

  def self.run
    new.fetch_and_process_from_sftp
  end

  def fetch_and_process_from_sftp
    sftp.dir.foreach(SFTP_PATH) do |file|
      filename = file.name
      if filename == "." || filename == ".."
        next
      end
      sftp_path = SFTP_PATH + "/#{filename}"
      data = sftp.download!(sftp_path)
      tmp_file = Tempfile.new
      tmp_file.write(data)
      tmp_file.close
      ProductImportWorker.new.perform(tmp_file.path)
      print "."
    end
  end

  private

  def sftp
    Net::SFTP.start(
      ENV.fetch("SFTP_HOST"),
      ENV.fetch("SFTP_USERNAME"),
      password: ENV.fetch("SFTP_PASSWORD"),
    )
  end
end
