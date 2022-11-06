import pysftp
import os
from dotenv import load_dotenv
load_dotenv()

def download_csvs():
  localFilePath = "/app"
  cnopts = pysftp.CnOpts()
  cnopts.hostkeys = None
  with pysftp.Connection(host=os.environ('REMOTE_IP'), username=os.environ('REMOT_UNAME'), password=os.environ('REMOT_PASS'), cnopts=cnopts) as sftp:
    print("Connection successfully established ... ")
    # Switch to a remote directory
    sftp.get_r("/var/tmp/csv_files/", localFilePath)
    print("done")
