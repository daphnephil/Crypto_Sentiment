import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    # API URL
    url = 'https://api.alternative.me/fng/?limit=0&format=json&date_format=cn'

# Send a GET request to the API
    response = requests.get(url)
# Check if the request was successful (status code 200)

    
    data = response.json()

    # Extract relevant data from the JSON
    fng_data = data['data']

    # Convert the data into a Pandas DataFrame
    fng_df = pd.DataFrame(fng_data)

    # Convert timestamp column to datetime
    fng_df['timestamp'] = pd.to_datetime(fng_df['timestamp'])
    # Print the DataFrame
    return fng_df






