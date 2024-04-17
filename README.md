# Crypto Sentiment Analysis Pipeline
This project aims to analyze cryptocurrency sentiment by collecting and analyzing historical data from the Bitstamp API for Bitcoin historical data and the Alternate.me Fear and Greed Index API for Bitcoin fear and greed index data. The pipeline is built to run on a Google Virtual Machine using Docker and utilizes Terraform and mage.ai for orchestration. Mage.ai is used for extracting data from the respective APIs and loading them into Google Cloud Storage and BigQuery. The data is then visualized using Looker.

## Table of Contents
* Introduction
* Setup
* Usage
* Contributing
* License

### Introduction
Cryptocurrencies have become increasingly popular as an investment option, but their value is highly volatile and influenced by various factors including market sentiment. Analyzing sentiment can provide valuable insights into market trends and help make informed decisions. This project aims to provide a comprehensive pipeline for analyzing cryptocurrency sentiment specifically focusing on Bitcoin.

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
