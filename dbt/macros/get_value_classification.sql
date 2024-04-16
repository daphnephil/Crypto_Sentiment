{#
    This macro returns the description of the value_classification 
#}

{% macro get_value_classification(value) -%}

    case {{ dbt.safe_cast("value", api.Column.translate_type("integer")) }}  
       when {{ value }} >= 0 and {{ value }} <= 24 then 'Extreme Fear'
        when {{ value }} >= 25 and {{ value }} <= 44 then 'Fear'
        when {{ value }} >= 45 and {{ value }} <= 55 then 'Neutral'
        when {{ value }} >= 56 and {{ value }} <= 75 then 'Greed'
        when {{ value }} >= 76 and {{ value }} <= 100 then 'Extreme Greed'
        else 'Unknown'
    end

{%- endmacro %}