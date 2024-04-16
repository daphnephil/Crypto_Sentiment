{{
    config(
        materialized='view'
    )
}}


with crypto_data as 
(

    select * 
    from {{ source('staging', 'crypto_data_partitoned') }}

)
select
    cast(timestamp as date) as trade_date,
    {{ dbt.safe_cast("volume", api.Column.translate_type("float")) }} as trade_volume,
    cast(price as numeric) as btc_usd_price
from crypto_data

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}


{% endif %}