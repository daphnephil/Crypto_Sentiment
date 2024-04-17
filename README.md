# Crypto Sentiment Analysis Pipeline
This project aims to analyze cryptocurrency sentiment by collecting and analyzing historical data from the BitcoinChart API for Bitcoin historical data and the Alternate.me Fear and Greed Index API for Bitcoin fear and greed index data. The pipeline is built to run on a Google Virtual Machine using Docker and utilizes Terraform for orchestration. Mage.ai, a workflow orchestration tool, is used for extracting data from the respective APIs and loading them into Google Cloud Storage and BigQuery. The data is then visualized using Looker.

## Table of Contents
[x] Introduction
[x] Setup
[x] Usage
[x] Contributing
[x] License

### Introduction
Cryptocurrencies have become increasingly popular as an investment option, but their value is highly volatile and influenced by various factors including market sentiment. Analyzing sentiment can provide valuable insights into market trends and help make informed decisions. This project aims to provide a comprehensive pipeline for analyzing cryptocurrency sentiment specifically focusing on Bitcoin.

### Setup
To set up the project locally, follow these steps:
1. Clone the Repository:
   ```
   git clone https://github.com/yourusername/cryptosentiment-analysis.git
```
2. Install Dependencies:
* Docker
* Terraform
* Mage.ai
* Google Cloud SDK
3. Configure Google Cloud:

* Set up a Google Cloud project.
* Configure authentication for your Google Cloud project.
* Enable necessary APIs (BigQuery, Google Cloud Storage, etc.)
4. Build Docker Image:
```
docker build -t cryptosentiment .
```
5.Run Docker Container:
```
docker run -it cryptosentiment
```

### Usage
Once the setup is complete, you can run the pipeline to collect and analyze cryptocurrency sentiment data. Here's how to use the pipeline:

1. Run Terraform:
Use Terraform to provision resources on Google Cloud Platform.

```
terraform apply
```

2. Execute Mage.ai:
Execute the Mage.ai workflow to extract data from BitcoinChart API and Alternate.me Fear and Greed Index API, and load it into Google Cloud Storage and BigQuery.

```
mage run workflow
```
3. Visualize Data:
Use Looker or any other visualization tool to analyze and visualize the collected data.

### Contributing
Contributions are welcome! If you'd like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (git checkout -b feature/improvement).
3. Make your changes.
4. Commit your changes (git commit -am 'Add new feature').
5. Push to the branch (git push origin feature/improvement).
6. Create a new Pull Request.
