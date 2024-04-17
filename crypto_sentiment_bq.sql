

-- Creating a partition and cluster table for the fng_data
CREATE OR REPLACE TABLE dtc-de-course-380621.crypto_sentiment.crypto_data_partitoned
PARTITION BY DATE(timestamp) AS
SELECT * FROM dtc-de-course-380621.crypto_sentiment.crypto_data;







-- Creating a partition and cluster table for the fng_data
CREATE OR REPLACE TABLE dtc-de-course-380621.crypto_sentiment.fng_data_partitoned_clustered
PARTITION BY DATE(timestamp)
CLUSTER BY value_classification AS
SELECT * FROM dtc-de-course-380621.crypto_sentiment.fng_data;


SELECT DISTINCT value_classification
FROM dtc-de-course-380621.crypto_sentiment.fng_data_partitoned_clustered;


SELECT  value_classification
FROM dtc-de-course-380621.crypto_sentiment.fng_data_partitoned_clustered;