import pysftp
import os
import dotenv
load_dotenv()

def download_csvs():
  localFilePath = "/app"
  cnopts = pysftp.CnOpts()
  cnopts.hostkeys = None
  with pysftp.Connection(host=os.environ.get('REMOTE_IP'), username=os.environ.get('REMOT_UNAME'), password=os.environ.get('REMOT_PASS'), cnopts=cnopts) as sftp:
    print("Connection successfully established ... ")
    # Switch to a remote directory
    sftp.get_r("/var/tmp/csv_files/", localFilePath)
    print("done")
