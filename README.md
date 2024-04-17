# Crypto Sentiment Analysis Pipeline
This project aims to analyze cryptocurrency sentiment by collecting and analyzing historical data from the Bitstamp API for Bitcoin historical data and the Alternate.me Fear and Greed Index API for Bitcoin fear and greed index data. The pipeline is built to run on a Google Virtual Machine using Docker and utilizes Terraform and mage.ai for orchestration. Mage.ai is used for extracting data from the respective APIs and loading them into Google Cloud Storage and BigQuery. The data is then visualized using Looker.

## Table of Contents
* Introduction
* Project Architecture
* Project Structure
* Data Ingestion
* Exporting Data to Data Lake and Data Warehouse
* Data Transformation
* Visualization
* Conclusion
* Reproduce this project
* Contributing
* License

### Introduction
Cryptocurrencies have become increasingly popular as an investment option, but their value is highly volatile and influenced by various factors including market sentiment. Analyzing sentiment can provide valuable insights into market trends and help make informed decisions. This project aims to provide a comprehensive pipeline for analyzing cryptocurrency sentiment specifically focusing on Bitcoin.


### Project Architecture

The project architecture involves several components working together:

* Bitstamp API: Provides historical data on Bitcoin prices.
* Alternate.me Fear and Greed Index API: Provides sentiment analysis data for Bitcoin.
* Google Virtual Machine: Hosts the pipeline using Docker.
* Terraform: Orchestrates the deployment of resources on Google Cloud Platform.
* Mage.ai: A workflow orchestration tool used for data extraction, transformation, and loading (ETL) tasks.
* Google Cloud Storage: Stores raw data extracted from APIs.
* Google BigQuery: Serves as a data warehouse for storing and querying structured data.
* dbt: transforms the data and builds fact and dimension models.
* Looker: Provides visualization and analysis capabilities for the data stored in BigQuery.

![Image of the project Architecture](https://github.com/daphnephil/Crypto_Sentiment/blob/main/Crypto_sentiment.svg)

### Project Structure
The project directory structure is organized as follows:
```
📦 
├─ Crypto_Sentiment_Analysis.pdf
├─ Crypto_sentiment.svg
├─ README.md
├─ dbt
│  ├─ .gitignore
│  ├─ .gitkeep
│  ├─ README.md
│  ├─ analyses
│  │  └─ .gitkeep
│  ├─ dbt_project.yml
│  ├─ macros
│  │  ├─ .gitkeep
│  │  └─ get_value_classification.sql
│  ├─ models
│  │  ├─ core
│  │  │  ├─ dim_crypto_sentiment.sql
│  │  │  ├─ fact_crypto_sentiment.sql
│  │  │  └─ schema.yml
│  │  └─ staging
│  │     ├─ schema.yml
│  │     ├─ stg_crypto_data_partitoned.sql
│  │     └─ stg_fng_data_partitoned_clustered.sql
│  ├─ package-lock.yml
│  ├─ packages.yml
│  ├─ snapshots
│  │  └─ .gitkeep
│  └─ tests
│     └─ .gitkeep
└─ gcp
   ├─ .gitignore
   ├─ crypto_sentiment_pipeline
   │  ├─ __init__.py
   │  ├─ __pycache__
   │  │  └─ __init__.cpython-310.pyc
   │  ├─ data_exporters
   │  │  ├─ __init__.py
   │  │  ├─ __pycache__
   │  │  │  ├─ __init__.cpython-310.pyc
   │  │  │  ├─ export_crypto_data_to_bq.cpython-310.pyc
   │  │  │  ├─ export_crypto_data_to_gcs.cpython-310.pyc
   │  │  │  ├─ export_fng_data_to_bq.cpython-310.pyc
   │  │  │  ├─ export_fng_data_to_gcs.cpython-310.pyc
   │  │  │  ├─ export_titanic_clean.cpython-310.pyc
   │  │  │  └─ load_crypto_data_to_gcs.cpython-310.pyc
   │  │  ├─ export_crypto_data_to_bq.py
   │  │  ├─ export_crypto_data_to_gcs.py
   │  │  ├─ export_fng_data_to_bq.py
   │  │  └─ export_fng_data_to_gcs.py
   │  ├─ data_loaders
   │  │  ├─ __init__.py
   │  │  ├─ __pycache__
   │  │  │  ├─ __init__.cpython-310.pyc
   │  │  │  ├─ creative_herald.cpython-310.pyc
   │  │  │  ├─ gg.cpython-310.pyc
   │  │  │  ├─ load_crypto_data_from_api.cpython-310.pyc
   │  │  │  ├─ load_crypto_data_from_gcs.cpython-310.pyc
   │  │  │  ├─ load_data_from_api.cpython-310.pyc
   │  │  │  ├─ load_fng_data_from_api.cpython-310.pyc
   │  │  │  ├─ load_fng_data_from_gcs.cpython-310.pyc
   │  │  │  ├─ load_titanic.cpython-310.pyc
   │  │  │  └─ unstoppable_runesmith.cpython-310.pyc
   │  │  ├─ load_crypto_data_from_api.py
   │  │  ├─ load_crypto_data_from_gcs.py
   │  │  ├─ load_fng_data_from_api.py
   │  │  └─ load_fng_data_from_gcs.py
   │  ├─ metadata.yaml
   │  ├─ transformers
   │  │  ├─ __init__.py
   │  │  ├─ __pycache__
   │  │  │  ├─ __init__.cpython-310.pyc
   │  │  │  ├─ fill_in_missing_values.cpython-310.pyc
   │  │  │  └─ transform_crypto_data.cpython-310.pyc
   │  │  └─ transform_crypto_data.py
   │  └─ triggers.yaml
   ├─ db.tf
   ├─ fs.tf
   ├─ load_balancer.tf
   ├─ main.tf
   └─ variables.tf
```

### Data Ingestion
Historical data from the Bitstamp API and sentiment analysis data from the Alternate.me Fear and Greed Index API are ingested using mage.ai. The ETL pipeline is scheduled to run monthly to ensure up-to-date analysis.

![mage_etl](https://github.com/daphnephil/Crypto_Sentiment/blob/main/Mage_ETL.png)

### Exporting Data to Datalake and Warehouse
The extracted data is exported to Google Cloud Storage and subsequently loaded into Google BigQuery. The crypto_data is partitioned based on the date column, and the fng_data is partitioned and clustered based on the date and value_classification column, respectively, for optimized querying.

### Data Transformation
Data transformation tasks are performed using dbt (data build tool). Fact and dimension models are built to organize and structure the data for analysis.

![dbt model](https://github.com/daphnephil/Crypto_Sentiment/blob/main/dbt-dag%20(3).png)
### Visualisation

The transformed data is visualized using Looker, a business intelligence and analytics platform. This enables stakeholders to gain insights through interactive dashboards and reports.

![Visualization with looker](https://github.com/daphnephil/Crypto_Sentiment/blob/main/Looker_Vis.png)

### Conclusion

The analysis reveals a correlation between Bitcoin prices and sentiment as measured by the Fear and Greed Index. However, it's important to note that this correlation is based on available data and should be interpreted cautiously.

## Reproduce this project
### Setup
To set up this project on google compute engine, follow these steps:
1. Set up google cloud by following this video description by [DataTalksClub](https://www.youtube.com/watch?v=ae-CV2KfoN0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=14)
2. Install Dependencies:
* Anaconda
* Python
* Docker
* Terraform
* Google Cloud SDK --All these are explained in the video link above

3. Configure Google Cloud:
* Set up a Google Cloud project.
* Configure authentication for your Google Cloud project.
* Enable necessary APIs (BigQuery, Google Cloud Storage, etc.)
* Allow the following permissions for the project;
     - Artifact Registry Reader
     - Artifact Registry writer
     - Cloud Run Developer
     - Cloud SQL Admin
     - Service Account Token Creator

3. Clone this repository 

   ```
   git clone https://github.com/daphnephil/Crypto_Sentiment.git
   ```
4. Edit the files as instructed in this [mage doc](https://docs.mage.ai/production/deploying-to-cloud/gcp/setup)

### Usage
Once the setup is complete, you can run the pipeline to collect and analyze cryptocurrency sentiment data. Here's how to use the pipeline:
1. From the VM cd to Crypto_Sentiment/gcp
2. Run Terraform:
Use Terraform to provision resources on Google Cloud Platform.
```
terraform init
```
```
terraform plan
```
```
terraform apply
```
This builds the docker image for mage.ai in google cloud and creates the required resources defined in the terraform files.

2. Execute Mage.ai:
- Navigate to Cloud Run on GCP
- Click on the name of the service you created
- Copy the URL and paste on your browser.
Execute the crypto_sentiment pipeline on Mage to extract data from Bitstamp API and Alternate.me Fear and Greed Index API, and load it into Google Cloud Storage and BigQuery.
3. Destroy Resources Created
  ```
  terraform destroy
  ```

5. Transforming data with dbt
  - Connect dbt to bigquery.
  - Run
    ```
    dbt build
    ```
    This builds the fact and dimension models.
5. Visualize Data:
Use Looker or any other visualization tool to analyze and visualize the fact_crypto_sentiment_data.

### Contributing
Contributions are welcome! If you'd like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (git checkout -b feature/improvement).
3. Make your changes.
4. Commit your changes (git commit -am 'Add new feature').
5. Push to the branch (git push origin feature/improvement).
6. Create a new Pull Request.

### License
This project is licensed under the MIT License
