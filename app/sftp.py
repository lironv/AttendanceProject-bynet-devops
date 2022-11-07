import pysftp
import os
import sys
from dotenv import load_dotenv
load_dotenv()

    
    
def download_csvs():
  localFilePath = "/app"
  cnopts = pysftp.CnOpts()
  cnopts.hostkeys = None
  with pysftp.Connection(host=os.environ.get('REMOTE_IP'), username=os.environ.get('REMOTE_UNAME'), password=os.environ.get('REMOTE_PASS'),port=22, cnopts=cnopts) as sftp:
    print("Connection successfully established ... ")
    # Switch to a remote directory
    sftp.get_r("/var/tmp/csv_files/", localFilePath)
    print("done")
