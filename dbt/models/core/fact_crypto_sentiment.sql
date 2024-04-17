{{
    config(
        materialized='table'
    )
}}
with crypto_data as (
    select *
    from {{ ref('stg_crypto_data_partitoned') }}
), 
fng_data as (
    select *
    from {{ ref('stg_fng_data_partitoned_clustered') }}
)

select 
crypto_data.trade_date,
crypto_data.btc_volume,
crypto_data.usd_volume,
crypto_data.close_btc,
fng_data.fng_value,
fng_data.value_classification
from crypto_data
left join fng_data
on crypto_data.trade_date = fng_data.trade_date