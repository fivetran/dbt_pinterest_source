{% macro get_advertiser_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "advertiser_id", "datatype": dbt_utils.type_string()},
    {"name": "clickthrough_1", "datatype": dbt_utils.type_int()},
    {"name": "clickthrough_2", "datatype": dbt_utils.type_int()},
    {"name": "date", "datatype": dbt_utils.type_timestamp()},
    {"name": "impression_1", "datatype": dbt_utils.type_int()},
    {"name": "impression_2", "datatype": dbt_utils.type_int()},
    {"name": "spend_in_micro_dollar", "datatype": dbt_utils.type_int()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('pinterest__advertiser_report_passthrough_metrics')) }}

{{ return(columns) }}

{% endmacro %}
