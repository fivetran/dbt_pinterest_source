{% macro get_pin_promotion_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "ad_group_id", "datatype": dbt.type_string()},
    {"name": "advertiser_id", "datatype": dbt.type_string()},
    {"name": "campaign_id", "datatype": dbt.type_string()},
    {"name": "clickthrough_1", "datatype": dbt.type_numeric()},
    {"name": "clickthrough_2", "datatype": dbt.type_numeric()},
    {"name": "date", "datatype": dbt.type_timestamp()},
    {"name": "impression_1", "datatype": dbt.type_numeric()},
    {"name": "impression_2", "datatype": dbt.type_numeric()},
    {"name": "pin_promotion_id", "datatype": dbt.type_string()},
    {"name": "spend_in_micro_dollar", "datatype": dbt.type_numeric()},
    {"name": "total_conversions", "datatype": dbt.type_int()},
    {"name": "total_conversions_quantity", "datatype": dbt.type_int()},
    {"name": "total_conversions_value_in_micro_dollar", "datatype": dbt.type_int()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('pinterest__pin_promotion_report_passthrough_metrics')) }}

{{ return(columns) }}

{% endmacro %}
