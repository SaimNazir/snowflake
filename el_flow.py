import time
from prefect import flow, task
import subprocess
from datetime import datetime

@task
def run_data_gen():
    subprocess.run(["python3", "data_gen.py"], check=True)

@task
def run_upload():
    subprocess.run(["python3", "upload.py"], check=True)

@task
def run_stage():
    subprocess.run(["python3", "stage.py"], check=True)

@flow(name="EL Pipeline Flow")
def el_pipeline():
    run_data_gen()
    run_upload()
    run_stage()

def run_loop():
    while True:
        print(f"[{datetime.now()}] Running EL pipeline...")

        try:
            el_pipeline()
            print(f"[{datetime.now()}] Run completed.\n")

        except Exception as e:
            print(f"[{datetime.now()}] Error during pipeline run: {e}\n")
        time.sleep(3)

if __name__ == "__main__":
    run_loop()
