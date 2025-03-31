import numpy as np
import pandas as pd
from faker import Faker
import random
import uuid
import os
from datetime import datetime

fake = Faker()

# 
platforms = ['PS4', 'Xbox One', 'PC', 'Switch', 'PS5', 'Xbox Series X']
genres = ['Action', 'Adventure', 'RPG', 'Sports', 'Strategy', 'Simulation']
publishers = ['Nintendo', 'EA', 'Activision', 'Ubisoft', 'Sony', 'Microsoft']
years = [float(y) for y in range(1980, 2025)]
base_dir = os.path.abspath("./generated_data")
os.makedirs(base_dir, exist_ok=True)


def generate_game_name():
    patterns = [
        f"{fake.word().capitalize()} {fake.word().capitalize()}",
        f"{fake.word().capitalize()} of {fake.word().capitalize()}",
        f"{fake.word().capitalize()}: {fake.word().capitalize()} {fake.word().capitalize()}",
        f"The {fake.word().capitalize()} of {fake.word().capitalize()}",
        f"{fake.word().capitalize()}'s {fake.word().capitalize()}",
        f"{fake.word().capitalize()} {random.randint(1, 10)}",
        f"{fake.word().capitalize()} {random.choice(['World', 'Legend', 'Chronicles', 'Quest', 'Adventure'])}"
    ]
    return random.choice(patterns)


def generate_game_record(rank):
    na_sales = round(random.uniform(0.01, 15.0), 2)
    eu_sales = round(random.uniform(0.01, 12.0), 2)
    jp_sales = round(random.uniform(0.01, 8.0), 2)
    other_sales = round(random.uniform(0.01, 5.0), 2)
    global_sales = round(na_sales + eu_sales + jp_sales + other_sales, 2)

    return {
        'Rank': rank,
        'Game_ID': str(uuid.uuid4()),
        'Name': generate_game_name(),
        'Platform': random.choice(platforms),
        'Year': float(random.choice(years)),
        'Genre': random.choice(genres),
        'Publisher': random.choice(publishers),
        'NA_Sales': na_sales,
        'EU_Sales': eu_sales,
        'JP_Sales': jp_sales,
        'Other_Sales': other_sales,
        'Global_Sales': global_sales,
        'Age_Rating': random.choice(["E", "T", "M"]),
        'Critic_Score': round(np.random.normal(75, 10), 1),
        'User_Score': round(np.random.normal(7, 1.5), 1),
        'Review_Count': random.randint(10, 10000),
        'Developer': random.choice(["Rockstar", "Bethesda", "Square Enix", "Ubisoft", "Nintendo", "Sony Studios"]),
        'Release_Season': random.choice(["Spring", "Summer", "Fall", "Winter"]),
        'Multiplayer_Support': random.choice([True, False]),
        'DLC_Available': random.choice([True, False]),
        'Remastered_Version': random.choice([True, False])
    }


def generate_synthetic_data(num_records, output_dir):
    print(f"Generating {num_records} records...")
    file_name = "game_data_raw.csv"
    file_path = os.path.join(output_dir, file_name)

    synthetic_df = pd.DataFrame([
        generate_game_record(rank=i + 1) for i in range(num_records)
    ])
    synthetic_df.to_csv(file_path, index=False)

    print(f"File saved at: {file_path} (Shape: {synthetic_df.shape})")



num_records = 5000
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
run_output_dir = os.path.join(base_dir, timestamp)
os.makedirs(run_output_dir, exist_ok=True)

generate_synthetic_data(num_records, run_output_dir)
