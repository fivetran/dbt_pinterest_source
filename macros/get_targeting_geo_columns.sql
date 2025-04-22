{% macro get_targeting_geo_columns() %}

{% set columns = [
    {"name": "country_id", "datatype": "dbt.type_string()"},
    {"name": "country_name", "datatype": "dbt.type_string()"},
    {"name": "_fivetran_synced", "datatype": "dbt.type_timestamp()"}
] %}

{# Make backwards compatible in case users were bringing in conversion metrics via passthrough columns prior to us adding them by default #}
{{ pinterest_ads_add_passthrough_columns(base_columns=columns, pass_through_fields=var('pinterest__targeting_geo_passthrough_metrics'), except_fields=['total_conversions', "total_conversions_quantity", "total_conversions_value_in_micro_dollar"]) }}

{{ return(columns) }}

{% endmacro %}
