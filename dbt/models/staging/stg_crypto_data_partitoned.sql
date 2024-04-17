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
    cast(date as date) as trade_date,
    {{ dbt.safe_cast("open", api.Column.translate_type("float")) }} as open_btc,
    {{ dbt.safe_cast("high", api.Column.translate_type("float")) }} as high_btc,
    {{ dbt.safe_cast("low", api.Column.translate_type("float")) }} as low_btc,
    {{ dbt.safe_cast("close", api.Column.translate_type("float")) }} as close_btc,
    {{ dbt.safe_cast("volume_BTC", api.Column.translate_type("float")) }} as btc_volume,
    {{ dbt.safe_cast("volume_USD", api.Column.translate_type("float")) }} as usd_volume
from crypto_data

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}


{% endif %}