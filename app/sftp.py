import pysftp

def download_csvs():
  Hostname = "185.164.16.144"
  Username = "lironv"
  Password = "123456"
  localFilePath = "/app"
  cnopts = pysftp.CnOpts()
  cnopts.hostkeys = None
  with pysftp.Connection(host=Hostname, username=Username, password=Password, cnopts=cnopts) as sftp:
    print("Connection successfully established ... ")
    # Switch to a remote directory
    sftp.get_r("/var/tmp/csv_files/", localFilePath)
    print("done")
   
   
   
