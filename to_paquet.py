import os
import pandas as pd

for file in os.listdir('csvs'):
    if file.endswith('.csv'):
        df = pd.read_csv(f'csvs/{file}', sep=';')
        if '_triangulos' in file:
            df.rename(columns={'Unnamed: 0': 'cohort'}, inplace=True)
        else:
            df.drop(['Unnamed: 0'], axis=1, inplace=True)
        df.to_parquet(f'parquets/{file.replace("csv", "parquet")}', index=False)