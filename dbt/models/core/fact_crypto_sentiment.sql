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
fng_data.trade_date,
crypto_data.trade_volume,
crypto_data.btc_usd_price,
fng_data.fng_value,
fng_data.value_classification
from crypto_data
inner join fng_data
on crypto_data.trade_date = fng_data.trade_date