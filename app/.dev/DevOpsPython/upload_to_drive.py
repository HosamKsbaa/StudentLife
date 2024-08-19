import argparse
import io
import os
from google.oauth2.service_account import Credentials
from googleapiclient.discovery import build
from googleapiclient.http import MediaIoBaseUpload
from httplib2 import Http

def upload_file_with_progress(service, file_path, file_metadata):
    """
    Upload a file to Google Drive with progress reporting.
    This function uses MediaIoBaseUpload for demonstration and assumes
    manual progress tracking.
    """
    file_size = os.path.getsize(file_path)
    # Open the file for reading in binary mode
    with open(file_path, 'rb') as f:
        # Create a MediaIoBaseUpload object for resumable uploads
        media = MediaIoBaseUpload(f, mimetype='application/octet-stream', resumable=True)

        # Create the request
        request = service.files().create(body=file_metadata, media_body=media)

        response = None
        while response is None:
            status, response = request.next_chunk()
            if status:
                print(f"Uploaded {int(status.progress() * 100)}%")
        print("Upload Complete")

def main(service_account_file, folder_id, file_path, file_name):
    # Define the required scopes
    SCOPES = ['https://www.googleapis.com/auth/drive.file']

    # Authenticate using the service account file
    credentials = Credentials.from_service_account_file(service_account_file, scopes=SCOPES)
    service = build('drive', 'v3', credentials=credentials)

    # Prepare the file upload metadata
    file_metadata = {'name': file_name, 'parents': [folder_id]}

    # Call the upload function
    upload_file_with_progress(service, file_path, file_metadata)

if __name__ == "__main__":
    # Parse command line arguments
    parser = argparse.ArgumentParser(description='Upload a file to Google Drive with progress reporting.')
    parser.add_argument('folder_id', help='Google Drive folder ID where the file will be uploaded')
    parser.add_argument('file_path', help='Path to the file to upload')
    parser.add_argument('file_name', help='Name of the file in Google Drive')

    args = parser.parse_args()

    main('pc-api-7342462637442119661-618-d13bd690cba4.json', args.folder_id, args.file_path, args.file_name)
