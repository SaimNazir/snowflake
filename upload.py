import os
import gzip
import shutil
import csv
from datetime import datetime
from azure.storage.blob import BlobServiceClient
from config import settings


AZURE_STORAGE_CONNECTION_STRING = settings.azure_storage_connection_string
CONTAINER_NAME = settings.container_name
SOURCE_DIR = os.path.abspath("./generated_data")


def add_timestamp_column_to_csv(csv_path):
    timestamp = datetime.utcnow().isoformat()

    temp_path = csv_path + ".tmp"

    with open(csv_path, 'r', newline='') as infile, open(temp_path, 'w', newline='') as outfile:
        reader = csv.reader(infile)
        writer = csv.writer(outfile)

        headers = next(reader)
        headers.append('loaded_at')
        writer.writerow(headers)

        for row in reader:
            row.append(timestamp)
            writer.writerow(row)

    shutil.move(temp_path, csv_path)
    print(f"[TIMESTAMP] Added timestamp to: {csv_path}")


def compress_csv_to_gzip(csv_path, gzip_path):
    with open(csv_path, 'rb') as f_in:
        with gzip.open(gzip_path, 'wb') as f_out:
            shutil.copyfileobj(f_in, f_out)
    print(f"[GZIP] Compressed: {gzip_path}")


def upload_to_azure(file_path, blob_name):
    blob_service_client = BlobServiceClient.from_connection_string(AZURE_STORAGE_CONNECTION_STRING)
    blob_client = blob_service_client.get_blob_client(container=CONTAINER_NAME, blob=blob_name)

    with open(file_path, "rb") as data:
        blob_client.upload_blob(data, overwrite=True)
    print(f"[UPLOAD] Uploaded to Azure Blob Storage: {blob_name}")


def main():
    folders = [f for f in os.listdir(SOURCE_DIR) if os.path.isdir(os.path.join(SOURCE_DIR, f))]
    if not folders:
        print("No folders found.")
        return

    latest_folder = sorted(folders)[-1]
    folder_path = os.path.join(SOURCE_DIR, latest_folder)

    for filename in os.listdir(folder_path):
        if filename.endswith('.csv'):
            csv_path = os.path.join(folder_path, filename)

            # Add timestamp column
            add_timestamp_column_to_csv(csv_path)

            gzip_filename = filename + '.gz'
            gzip_path = os.path.join(folder_path, gzip_filename)

            # Compress to gzip
            compress_csv_to_gzip(csv_path, gzip_path)

            # Upload compressed file
            blob_name = f"{latest_folder}/{gzip_filename}"
            upload_to_azure(gzip_path, blob_name)

    shutil.rmtree(folder_path)
    print(f"[CLEANUP] Deleted local folder: {latest_folder}")


if __name__ == "__main__":
    main()
