{{
    config(
        materialized='view'
    )
}}


with fng_data as 
(

    select * 
    from {{ source('staging', 'fng_data_partitoned_clustered') }}

)
select

    cast(timestamp as date) as trade_date,
    {{ dbt.safe_cast("value", api.Column.translate_type("integer")) }} as fng_value,
    value_classification
from fng_data

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}


{% endif %}

