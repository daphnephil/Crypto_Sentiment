{{ config(materialized='table') }}

WITH crypto_sentiment AS (
    SELECT * FROM {{ ref('fact_crypto_sentiment') }}
)

SELECT
    AVG(close_btc) AS avg_btc_price,
    AVG(fng_value) AS avg_fng_value,
    CORR(close_btc, fng_value) AS correlation_coefficient,
    SUM(btc_volume) AS total_btc_volume,
    SUM(usd_volume) AS total_usd_volume,
    AVG(fng_value) OVER () AS rolling_avg_fng_value,
    AVG(close_btc) OVER () AS rolling_avg_btc_price,
    PERCENTILE_CONT(close_btc, 0.5) OVER () AS median_btc_price,
    PERCENTILE_CONT(close_btc, 0.25) OVER () AS lower_quartile_btc_price,
    PERCENTILE_CONT(close_btc, 0.75) OVER () AS upper_quartile_btc_price,
    PERCENTILE_CONT(fng_value, 0.5) OVER () AS median_fng_value,
    PERCENTILE_CONT(fng_value, 0.25) OVER () AS lower_quartile_fng_value,
    PERCENTILE_CONT(fng_value, 0.75) OVER () AS upper_quartile_fng_value


FROM crypto_sentiment
GROUP BY fng_value,close_btc





